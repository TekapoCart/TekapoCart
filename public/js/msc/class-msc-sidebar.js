(function() {
	//navigator.whenDefined
	if (typeof navigator.whenDefined !== 'function') {
		Object.defineProperty(navigator, 'whenDefined', {
			configurable: false,
			enumerable: true,
			value: function() {
				let units;

				units = Array.from(arguments);
				if (units.indexOf('document.body') === -1) {
					units.push('document.body');
				}
				const promises = units.map(
					(unit) => {
						return new Promise((resolve, reject) => {
							let c, max, iid
							
							c = 0;
							max = 10000;

							iid = setInterval(() => {
								let _root, parts
								c += 5;
								if (c > max) {
									clearInterval(iid);
									reject(new Error(`"${unit}" unit missing.`));
								}

								_root = window;
								parts = unit.split('.');
								while (parts.length) {
									let prop
									prop = parts.shift();
									if (typeof _root[prop] === 'undefined') {
										_root = null;
										break;
									} else {
										_root = _root[prop];
									}
								}

								if (_root !== null) {
									clearInterval(iid);
									resolve();
								}
							}, 5);
						});
					}
				)

				return Promise.all(promises);
			}
		});
	}

	if (typeof window.MscSidebar !== 'undefined') return; 

	//web component starts here
	let enviromentInit, isInit, overScrollSupport, scrollY;

	isInit = false;
	enviromentInit = () => {
		let propValue;

		if (isInit) return;

		isInit = true;
		
		overScrollSupport = CSS.supports('overscroll-behavior:contain');
		propValue = {
			'overflow': 'hidden',
			'pointer-events': 'none'
		};

		if (!overScrollSupport) {
			/**
			 * referrnce:
			 * https://davidwalsh.name/prevent-body-scrolling
			 * https://www.bram.us/2016/05/02/prevent-overscroll-bounce-in-ios-mobilesafari-pure-css/
			 * https://code.i-harness.com/zh-TW/q/9c3884
			 * https://medium.com/jsdownunder/locking-body-scroll-for-all-devices-22def9615177
			 * https://stackoverflow.com/questions/41594997/ios-10-safari-prevent-scrolling-behind-a-fixed-overlay-and-maintain-scroll-posi
			 */
			propValue = {
				...propValue,
				'position': 'fixed',
				'top': '0',
				'left': '0',
				'width': '100%',
				'height': '100vh',
				'box-sizing': 'border-box',
				'margin-top': 'var(--scroll-lock)'
			}
		}
		_wcl.addStylesheetRules('.scroll-lock', propValue);
	};

	const template = document.createElement('template');
	template.innerHTML = `
		<style>
		/*reset*/
		div,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,legend,input,textarea,p,article,aside,figcaption,figure,nav,section,mark,audio,video,main{margin:0;padding:0}
		article,aside,figcaption,figure,nav,section,main{display:block}
		fieldset,img{border:0}
		address,caption,cite,em,strong{font-style:normal;font-weight:400}
		ol,ul{list-style:none}
		caption{text-align:left}
		h1,h2,h3,h4,h5,h6{font-size:100%;font-weight:400}
		abbr{border:0;font-variant:normal}
		input,textarea,select{font-family:inherit;font-size:inherit;font-weight:inherit;}
		body{-webkit-text-size-adjust:none}
		select,input,button,textarea{font:100% arial,helvetica,clean,sans-serif}
		del{font-style:normal;text-decoration:none}
		pre{font-family:monospace;line-height:100%}

		/*component style*/
		:host{
			--overlay-color:rgba(0,0,0,.2);
			--timing-function:cubic-bezier(0,0,.21,1);
			--duration:233ms;
			--z-index:1000;
		}

		.overscrolling{-webkit-overflow-scrolling:touch;overflow:hidden;overflow-y:scroll;overscroll-behavior:contain;}

		:host{all:initial;position:fixed;font-family:sans-serif;text-size-adjust:100%;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%;font-size:16px;left:0;top:0;width:0;height:0;-webkit-tap-highlight-color:transparent;z-index:-1;transition:background var(--duration) var(--timing-function);overflow:hidden;pointer-events:none;visibility:hidden;opacity:0;}
		.msc-sidebar__restrict{position:absolute;left:0;height:100vh;max-width:80vw;background-color:#fff;display:inline-block;transform:translateX(-100%);transition:transform var(--duration) var(--timing-function);will-change:transform;}

		/*side*/
		:host([side='left']) .msc-sidebar__restrict{left:0;transform:translateX(-100%);}
		:host([side='right']) .msc-sidebar__restrict{left:auto;right:0;transform:translateX(100%);}

		/*animation*/
		:host([ready]){width:100%;height:100%;visibility:visible;opacity:1;pointer-events:auto;z-index:var(--z-index);}
		:host([open]){width:100%;height:100%;visibility:visible;opacity:1;pointer-events:auto;background-color:var(--overlay-color);transform:translate3d(0,0,0);z-index:var(--z-index);}
		:host([open]) .msc-sidebar__restrict{transform:translateX(0%) translate3d(0,0,0);}
		</style>
		<div class="msc-sidebar__restrict overscrolling">
			<slot></slot>
		</div>
	`;

	const supportSides = [
		'left',
		'right'
	];

	class MscSidebar extends HTMLElement {
		constructor() {
			super();

			//enviromentInit
			enviromentInit();

			//template
			this.attachShadow({mode: 'open'});
			this.shadowRoot.appendChild(template.content.cloneNode(true));

			//data
			this._nodes = {};
			this._nodes.styleSheet = this.shadowRoot.querySelector('style');
			this._nodes.restrict = this.shadowRoot.querySelector('.msc-sidebar__restrict');

			//evt
			this._onClick = this._onClick.bind(this);
			this._onTransitionend = this._onTransitionend.bind(this);
		}

		connectedCallback() {
			this._upgradeProperty('open');
			this._upgradeProperty('side');

			//evt
			this.addEventListener('click', this._onClick);
			this._nodes.restrict.addEventListener('transitionend', this._onTransitionend);
		}

		disconnectedCallback() {
			//evt
			this.removeEventListener('click', this._onClick);
			this._nodes.restrict.removeEventListener('transitionend', this._onTransitionend);
		}

		attributeChangedCallback(attrName, oldValue, newValue) {
			const hasValue = newValue !== null;

			switch (attrName) {
				case 'open':
					if (hasValue) {
						if (!this.hasAttribute('ready')) {
							this.setAttribute('ready', true);
						}
						
						this._nodes.restrict.scrollTop = 0;
						this._scrollLock(true);
					}

					//custom event
					this.dispatchEvent(new Event('curtain-change', { bubbles:true, composed:true }));
					break;
				case 'side':
					if (!hasValue || supportSides.indexOf(newValue) === -1) {
						this.setAttribute('side', supportSides[0]);
					}
					break;
			}
		}

		static get observedAttributes() {
			return ['open', 'side'];
		}		

		static get observedSides() {
			return supportSides;
		}

		set side(value) {
			if (supportSides.indexOf(value) === -1) {
				value = supportSides[0];
			}
			return this.setAttribute('side', value);
		}

		get side() {
			return this.getAttribute('side') || supportSides[0];
		}

		set open(value) {
			const force = Boolean(value);

			return (force) ? this.curtainRaising() : this.curtainCall();
		}

		get open() {
			return this.hasAttribute('open');
		}

		_upgradeProperty(prop) {
			if (this.hasOwnProperty(prop)) {
				let value;

				value = this[prop];
				delete this[prop];
				this[prop] = value;
			}
		}

		_onClick(e) {
			if (e.target === this) {
				this.curtainCall();
			}
		}

		_onTransitionend(e) {
			if (this.open) {
				return;
			}

			if (this.hasAttribute('ready')) {
				this.removeAttribute('ready');
			}

			this._scrollLock(false);
		}

		_scrollLock(value) {
			const isLock = Boolean(value);

			if (isLock) {
				if (document.body.classList.contains('scroll-lock')) {
					return;
				}

				if (!overScrollSupport) {
					scrollY = _wcl.scrollY;
					_wcl.addStylesheetRules('body.scroll-lock', {
						'--scroll-lock': `-${scrollY}px`
					});
				}
				document.body.classList.add('scroll-lock');
			} else {
				document.body.classList.remove('scroll-lock');
				if (!overScrollSupport) {
					_wcl.scrollY = scrollY;
				}
			}
		}

		curtainRaising() {
			if (!this.hasAttribute('ready')) {
				this.setAttribute('ready', true);
			}

			this.setAttribute('open', true);
		}

		curtainCall() {
			this.removeAttribute('open');
		}

		toggle(value) {
			let isOpen;

			if (typeof value !== 'undefined') {
				isOpen = !Boolean(value);
			} else {
				isOpen = this.open;
			}

			return (!isOpen) ? this.curtainRaising() : this.curtainCall();
		}
	}

	if (window) window.MscSidebar = MscSidebar;

	//customElements define
	navigator.whenDefined('_wcl', 'MscSidebar').then(
		() => {
			let supports;

			supports = _wcl.supports();
			if (supports.customElements && supports.shadowDOM && supports.template) {
				customElements.define(_wcl.classToTagName('MscSidebar'), MscSidebar);
			}
		},
		(err) => {
			console.error(`${_wcl.classToTagName('MscSidebar')}: ${err.message}`);
		}
	);
})();
