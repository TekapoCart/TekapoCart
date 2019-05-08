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

    if (typeof window.MdcSelect !== 'undefined') return;


    //web component starts here
    let enviromentInit, isInit;

    isInit = false;
    enviromentInit = () => {
        if (isInit) return;

        isInit = true;

        //css
        _wcl.addStylesheetRules('mdc-select select', { 'line-height':'1.75em', 'font-size': '16px' });
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
			--theme-color: #018786;
			--label: rgba(0,0,0,.6);
			--border-color: rgba(142,142,142,.5);
			--border-color-hover: rgba(142,142,142,1);
			--duration: .15s;
			--timing-function: cubic-bezier(.4,0,.2,1);
			--bgcolor: rgba(245,245,245,.5);
			--bgcolor-hover: rgba(245,245,245,1);
		}
		:host{all:initial;font-family:sans-serif;text-size-adjust:100%;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%;font-size:16px;-webkit-tap-highlight-color:transparent;}
		:host{position:relative;height:56px;background-color:var(--bgcolor);border-radius:4px 4px 0 0;display:inline-block;overflow:hidden;transition:background-color var(--duration) var(--timing-function);box-sizing:border-box;}
		::slotted(select){font-size:1em;line-height:1.75em;padding:14px 52px 14px 16px;display:inline-block;background:none;border:0 none;outline:0 none;border-radius:0;appearance:none;-webkit-appearance:none;white-space:nowrap;}
		::slotted(select){color:#000;color:rgba(0,0,0,0);text-shadow:0 0 0 #000;}
		.pool{position:absolute;left:0;bottom:0;width:100%;height:1px;background-color:var(--border-color);pointer-events:none;transition:background-color var(--duration) var(--timing-function),transform var(--duration) var(--timing-function);}
		.pool::before{content:'';position:absolute;width:100%;height:100%;background-color:var(--theme-color);transform-origin:50% 50%;transition:transform var(--duration) var(--timing-function);transform:scaleX(0);}
		.ico-dropdown{position:absolute;width:1.5em;height:1.5em;right:8px;top:50%;margin-top:-.75em;transition:transform var(--duration) var(--timing-function);pointer-events:none;}
		.ico-dropdown svg{display:block;transition:fill var(--duration) var(--timing-function);}
		label{position:absolute;left:16px;top:14px;font-size:1em;color:var(--label);line-height:1.75em;display:block;transition:color var(--duration) var(--timing-function),transform var(--duration) var(--timing-function);transform-origin:0% 0%;pointer-events:none;}
		
		:host(:hover){background-color:var(--bgcolor-hover);}
		:host(:hover) .pool{background-color:var(--border-color-hover);}
		:host(:hover) label{color:currentColor;}
		:host(:focus-within){background-color:var(--bgcolor-hover);}
		:host(:focus-within) .pool{background-color:var(--theme-color);transform:scaleY(2);transform-origin:50% 100%;}
		:host(:focus-within) .pool::before{transform:scaleX(1);}
		:host(:focus-within) .ico-dropdown{transform:rotate(180deg) translateY(-5px);}
		:host(:focus-within) .ico-dropdown svg{fill:var(--theme-color);}
		:host(:focus-within) label{color:var(--theme-color);}
		
		:host([disabled]){pointer-events:none;opacity:.5;}
		:host([readonly]){pointer-events:none;opacity:.5;}
		:host([disabled]) ::slotted(select){pointer-events:none;}
		:host([readonly]) ::slotted(select){pointer-events:none;}

		/*filled*/
		:host([data-type='filled']:focus-within) label{transform:translateY(-30%) scale(.75);}
		:host([data-type='filled']:focus-within) ::slotted(select){padding-top:22px;}
		:host(.selected[data-type='filled']) label{transform:translateY(-30%) scale(.75);}
		:host(.selected[data-type='filled']) ::slotted(select){padding-top:22px;}

		/*shaped-filled*/
		:host([data-type='shaped-filled']){border-radius:1.125em 1.125em 0 0;}
		:host([data-type='shaped-filled']:focus-within) label{transform:translateY(-30%) scale(.75);}
		:host([data-type='shaped-filled']:focus-within) ::slotted(select){padding-top:22px;}
		:host(.selected[data-type='shaped-filled']) label{transform:translateY(-30%) scale(.75);}
		:host(.selected[data-type='shaped-filled']) ::slotted(select){padding-top:22px;}

		/*outlined*/
		:host([data-type='outlined']){border-radius:4px;border:1px solid var(--border-color);background-color:transparent;overflow:visible;transition:border var(--duration) var(--timing-function);}
		:host([data-type='outlined']) label{padding:0 6px;left:10px;}
		:host([data-type='outlined']) .pool{display:none;}
		:host([data-type='outlined']:hover){border-color:var(--border-color-hover);background:transparent;}
		:host([data-type='outlined']:focus-within){background-color:transparent;}
		:host([data-type='outlined']:focus-within) label{transform:translateY(-90%) scale(.75);background:#fff;}
		:host([data-type='outlined']:focus-within){border:2px solid var(--theme-color);}
		:host(.selected[data-type='outlined']) label{transform:translateY(-90%) scale(.75);background:#fff;}

		/*shaped-outlined*/
		:host([data-type='shaped-outlined']){border-radius:56px;border:1px solid var(--border-color);background-color:transparent;overflow:visible;transition:border var(--duration) var(--timing-function);}
		:host([data-type='shaped-outlined']) ::slotted(select){padding:14px 52px 14px 32px;}
		:host([data-type='shaped-outlined']) label{padding:0 6px;left:26px;}
		:host([data-type='shaped-outlined']) .pool{display:none;}
		:host([data-type='shaped-outlined']:hover){border-color:var(--border-color-hover);background:transparent;}
		:host([data-type='shaped-outlined']:focus-within){background-color:transparent;}
		:host([data-type='shaped-outlined']:focus-within) label{transform:translateY(-90%) scale(.75);background:#fff;}
		:host([data-type='shaped-outlined']:focus-within){border:2px solid var(--theme-color);}
		:host(.selected[data-type='shaped-outlined']) label{transform:translateY(-90%) scale(.75);background:#fff;}
		</style>

		<slot name="select"></slot>
		<label>label</label>
		<div class="ico-dropdown">
			<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
				<path d="M7 10l5 5 5-5z"/>
				<path d="M0 0h24v24H0z" fill="none"/>
			</svg>
		</div>
		<div class="pool"></div>
	`;

    const stuff = document.createElement('template');
    stuff.innerHTML = `
		<select slot="select">
			<option disabled selected></option>
		</select>
	`;

    const supportTypes = [
        'filled',
        'shaped-filled',
        'outlined',
        'shaped-outlined'
    ];

    class MdcSelect extends HTMLElement {
        constructor() {
            super();

            //enviromentInit
            enviromentInit();

            //template
            this.attachShadow({mode: 'open'});
            this.shadowRoot.appendChild(template.content.cloneNode(true));

            //data
            this._data = {};
            this._nodes = {};
            this._nodes.styleSheet = this.shadowRoot.querySelector('style');
            this._nodes.select = this.querySelector('select');
            this._nodes.label = this.shadowRoot.querySelector('label');
            this._nodes.labelLight = this.querySelector('label');

            //evt
            this._onChange = this._onChange.bind(this);
            this._onFocus = this._onFocus.bind(this);
            this.observer = new MutationObserver(
                    mutations => mutations.forEach(mutation => this._mutate(mutation))
        );
        }

        connectedCallback() {
            let { select, labelLight } = this._nodes;

            //stuff plug
            if (!select) {
                this.appendChild(stuff.content.cloneNode(true));
                select = this.querySelector('select');
                this._nodes.select = select;
            }

            if (!labelLight) {
                this.appendChild(document.createElement('label'));
                labelLight = this.querySelector('label');
                labelLight.textContent = 'label';
                this._nodes.labelLight = labelLight;
            }

            //correct
            this.selectCorrect();
            if (supportTypes.indexOf(this.dataset.type) === -1) {
                this.dataset.type = supportTypes[0];
            }

            this._nodes.label.textContent = (this._nodes.labelLight) ? this._nodes.labelLight.textContent : '';

            //initial
            if (!this.hasAttribute('role')) {
                this.setAttribute('role', 'select');
            }

            if (!this.hasAttribute('tabindex')) {
                this.setAttribute('tabindex', 0);
            }

            this._upgradeProperty('readonly');
            this._upgradeProperty('disabled');

            //evt
            select.addEventListener('change', this._onChange);
            this.addEventListener('focus', this._onFocus);
            this.observer.observe(select, {
                attributes: true,
                childList: true
            });
        }

        disconnectedCallback() {
            let { select } = this._nodes;

            //evt
            select.removeEventListener('change', this._onChange);
            this.removeEventListener('focus', this._onFocus);
            this.observer.disconnect();
        }

        attributeChangedCallback(attrName, oldValue, newValue) {
            const hasValue = newValue !== null;

            switch (attrName) {
                case 'data-type':
                    if (supportTypes.indexOf(newValue) === -1) {
                        this.dataset.type = supportTypes[0];
                    }
                    break;
                case 'disabled':
                    this.setAttribute('aria-disabled', hasValue);
                    this._nodes.select.setAttribute('aria-disabled', hasValue);
                    if (hasValue) {
                        this.setAttribute('tabindex', '-1');
                        this._nodes.select.setAttribute('tabindex', '-1');
                        if (!this._nodes.select.hasAttribute('disabled')) {
                            this._nodes.select.setAttribute('disabled', '');
                        }
                        this.blur();
                    } else {
                        this.setAttribute('tabindex', '0');
                        this._nodes.select.setAttribute('tabindex', '0');
                        if (this._nodes.select.hasAttribute('disabled')) {
                            this._nodes.select.removeAttribute('disabled');
                        }
                    }
                    break;
                case 'readonly':
                    this.setAttribute('aria-readonly', hasValue);
                    this._nodes.select.setAttribute('aria-readonly', hasValue);
                    if (hasValue) {
                        this.setAttribute('tabindex', '-1');
                        this._nodes.select.setAttribute('tabindex', '-1');
                        if (!this._nodes.select.hasAttribute('readonly')) {
                            this._nodes.select.setAttribute('readonly', '');
                        }
                        this.blur();
                    } else {
                        this.setAttribute('tabindex', '0');
                        this._nodes.select.setAttribute('tabindex', '0');
                        if (this._nodes.select.hasAttribute('readonly')) {
                            this._nodes.select.removeAttribute('readonly');
                        }
                    }
                    break;
            }
        }

        selectCorrect() {
            let { select, options, node, selected } = this._nodes

            if (!select.hasAttribute('slot') || select.getAttribute('slot') !== 'select') {
                select.setAttribute('slot', 'select');
            }

            options = Array.from(select.querySelectorAll('option'));
            selected = options.filter((option) => option.hasAttribute('selected'));

            if (!options.length || options[0].value) {
                node = document.createElement('option');
                node.textContent = '';
                node.value = '';
                node.setAttribute('disabled', '');

                if (options.length) {
                    select.insertBefore(node, options[0]);
                } else {
                    select.appendChild(node);
                }
            }

            //with attribute - selected
            if (selected.length) {
                select.value = selected[0].value;
                this.classList.toggle('selected', true);
            } else {
                select.selectedIndex = 0;
                this.classList.toggle('selected', false);
            }
        }

        static get observedAttributes() {
            return ['disabled', 'data-type', 'readonly'];
        }

        static get supportTypes() {
            return supportTypes;
        }

        set type(value) {
            if (supportTypes.indexOf(value) !== -1) {
                this.dataset.type = value;
            }
        }

        get type() {
            return this.dataset.type;
        }

        set readOnly(value) {
            const isReadonly = Boolean(value);
            if (isReadonly) {
                this.setAttribute('readonly', '');
            } else {
                this.removeAttribute('readonly');
            }
        }

        get readOnly() {
            return this.hasAttribute('readonly');
        }

        set disabled(value) {
            const isDisabled = Boolean(value);
            if (isDisabled) {
                this.setAttribute('disabled', '');
            } else {
                this.removeAttribute('disabled');
            }
        }

        get disabled() {
            return this.hasAttribute('disabled');
        }

        set value(value) {
            this.classList.toggle('selected', value);
            return this._nodes.select.value = value;
        }

        get value() {
            return this._nodes.select.value;
        }

        set name(value) {
            return this._nodes.select.name = value;
        }

        get name() {
            return this._nodes.select.name;
        }

        _upgradeProperty(prop) {
            if (this.hasOwnProperty(prop)) {
                let value;

                value = this[prop];
                delete this[prop];
                if (/readonly/i.test(prop)) {
                    prop = 'readOnly';
                }
                this[prop] = value;
            }
        }

        _mutate(mutation) {
            const { attributeName, oldValue, target } = mutation;

            switch (mutation.type) {
                case 'attributes':
                    if (mutation.type !== 'attributes' ||
                        MdcSelect.observedAttributes.indexOf(attributeName) === -1) {
                        return;
                    }

                    if (!/data-/.test(attributeName)) {
                        if (/readonly/i.test(attributeName)) {
                            this.readOnly = target.hasAttribute(attributeName);
                        } else {
                            this[attributeName] = target.hasAttribute(attributeName);
                        }
                    }
                    break;
                case 'childList':
                    this.selectCorrect();
                    break;
            }
        }

        _onChange(e) {
            this.classList.toggle('selected', e.target.value.length > 0);
        }

        _onFocus(e) {
            let { select } = this._nodes;
            if (this.readOnly || this.disabled) {
                return;
            }
            select.focus();
        }
    }

    if (window) window.MdcSelect = MdcSelect;


    //customElements define
    navigator.whenDefined('_wcl', 'MdcSelect').then(
        () => {
        let supports;

    supports = _wcl.supports();
    if (supports.customElements && supports.shadowDOM && supports.template) {
        customElements.define(_wcl.classToTagName('MdcSelect'), MdcSelect);
    }
},
    (err) => {
        console.error(`${_wcl.classToTagName('MdcSelect')}: ${err.message}`);
    }
    );
})();