(function() {
	let _wcl;

	_wcl = window._wcl || {};
	Object.defineProperties(_wcl, {
		camelCase: {
			configurable: true,
			enumerable: true,
			value: function(str) {
				return str.replace(/-([a-z])/ig,
					function(all, letter) {
						return letter.toUpperCase();
					}
				);
			}
		},
		capitalize: {
			configurable: true,
			enumerable: true,
			value: function(str) {
				return str.replace(/^[a-z]{1}/,
					function($1) {
						return $1.toUpperCase()
					}
				);
			}
		},
		classToTagName: {
			configurable: true,
			enumerable: true,
			value: function(str) {
				return str.replace(/([A-Z])/g,
					function(all, letter) {
						return '-' + letter.toLowerCase();
					}
				).replace(/^-(.*)/, '$1');
			}
		},
		isNumeric: {
			configurable: true,
			enumerable: true,
			value: (value) => !isNaN(value - parseFloat(value))
		},
		isEventSupport: {
			configurable: true,
			enumerable: true,
			value: function(eventName, element) {
				/**
				 * reference:
				 * http://perfectionkills.com/detecting-event-support-without-browser-sniffing/
				 * @example
				 isEventSupport('touchstart');
				 */

				let node, flag;

				navigator.supports = navigator.supports || {};
				navigator.supports.event = navigator.supports.event || {};

				if (typeof navigator.supports.event[eventName] !== 'undefined') {
					flag = navigator.supports.event[eventName];
				} else {
					if (element) {
						node = (element.tagName) ? element.cloneNode(true) : element;
					} else {
						node = document.createElement('div');
					}

					flag = `on${eventName}` in node;

					if (!flag && node.setAttribute) {
						node.setAttribute(eventName, 'return;');
						flag = typeof node[eventName] == 'function';
					}

					navigator.supports.event[eventName] = flag;
					node = null;
				}

				return flag;
			}
		},
		isCSSPropertySupport: {
			configurable: true,
			enumerable: true,
			value: function(property) {
				/**
				 * @example
				 isCSSPropertySupport('overscroll-behavior');
				 */

				let node, flag;

				navigator.supports = navigator.supports || {};
				navigator.supports.css = navigator.supports.css || {};

				property = (/^-ms/.test(property)) ? ('ms' + this.camelCase(property.replace(/-ms/,''))) : this.camelCase(property);

				if (typeof navigator.supports.css[property] !== 'undefined') {
					flag = navigator.supports.css[property];
				} else {
					node = document.createElement('div');
					flag = property in node.style;
					navigator.supports.css[property] = flag;
					node = null;
				}

				return flag;
			}
		},
		scrollY: {
			configurable: true,
			enumerable: true,
			get: () => {
				return _wcl.getScroll().y;
			},
			set: (y) => {
				if (document.documentElement && document.documentElement.scrollTop) {
					document.documentElement.scrollTop = y;
				} else {
					document.body.scrollTop = y;
				}
			}
		},
		pointer: {
			configurable: true,
			enumerable: true,
			value: function(e) {
				let x, y, docElement, body;
				
				docElement = document.documentElement;

				//x
				body = document.body || { scrollLeft: 0 };
				x = e.pageX || (e.clientX + (docElement.scrollLeft || body.scrollLeft) - (docElement.clientLeft || 0));

				//y
				body = document.body || { scrollTop: 0 };
				y = e.pageY || (e.clientY + (docElement.scrollTop || body.scrollTop) - (docElement.clientTop || 0));

				return {x, y};
			}
		},
		pursuer: {
			configurable: true,
			enumerable: true,
			value: function() {
				let down, move, up;

				if (this.isEventSupport('touchstart')) {
					down = 'touchstart';
					move = 'touchmove';
					up = 'touchend';
				} else if (typeof navigator.msPointerEnabled != 'undefined' && navigator.msPointerEnabled) {
					down = 'MSPointerDown';
					move = 'MSPointerMove';
					up = 'MSPointerUp';
				} else {
					down = 'mousedown';
					move = 'mousemove';
					up = 'mouseup';
				}

				return {down, move, up}
			}
		},
		supports: {
			configurable: true,
			enumerable: true,
			value: function() {
				let flag;
				navigator.supports = navigator.supports || {};
				if (!navigator.supports.wp) {
					flag = true;
					try {
						class DummyClass {}
					} catch (err) {
						flag = false;
					}

					navigator.supports.wp = {
						classes: flag,
						customElements: 'customElements' in window,
						import: 'import' in document.createElement('link'),
						shadowDOM: !!HTMLElement.prototype.attachShadow,
						template: 'content' in document.createElement('template')
					};
				}
				return navigator.supports.wp
			}
		},
		getScroll: {
			configurable: true,
			enumerable: true,
			value: () => {
				let x, y
				x = (self.pageXOffset) ? self.pageXOffset : (document.documentElement && document.documentElement.scrollLeft) ? document.documentElement.scrollLeft : document.body.scrollLeft;
				y = (self.pageYOffset) ? self.pageYOffset : (document.documentElement && document.documentElement.scrollTop) ? document.documentElement.scrollTop : document.body.scrollTop;
				return {x, y};
			}
		},
		getPosition: {
			configurable: true,
			enumerable: true,
			value: (element) => {
				let x, y;
				x = 0;
				y = 0;
				while (element != null) {
					x += element.offsetLeft;
					y += element.offsetTop;
					element = element.offsetParent;
				}
				return {x, y};
			}
		},
		getSize: {
			configurable: true,
			enumerable: true,
			value: (element) => {
				let width, height;

				width = element.offsetWidth;
				height = element.offsetHeight;
				return {width, height};
			}
		},
		getRand: {
			configurable: true,
			enumerable: true,
			value: (min, max) => Math.floor(Math.random() * (max - min + 1) + min)
		},
		grabStyleSheet: {
			configurable: true,
			enumerable: true,
			value: function() {
				return navigator.customStyleSheet || (function() {
					navigator.customStyleSheet = document.createElement('style');
					document.head.appendChild(navigator.customStyleSheet);
					return navigator.customStyleSheet;
				})();
			}
		},
		addStylesheetRules: {
			configurable: true,
			enumerable: true,
			value: function(selector = '', props = {}, styleSheet = this.grabStyleSheet()) {
				/**
				 * Add a stylesheet rule to the document
				 * @example
				 addStylesheetRules(
					'body',
					{
						background: '#f00',
						color: '#0f0'
					}
					[, styleSheet]
				 )

				 addStylesheetRules(
					'@keyframes fancy-anchor-ripple',
					{
						'0%': '{transform:scale(1);opacity:1;}',
						'100%': '{transform:scale(100);opacity:0;}'
					}
					[, styleSheet]
				 )
				 */
				if (!selector || !Object.keys(props).length || !styleSheet.sheet) return;

				let propStr, findIndex, sign;

				sign = (/keyframes/i.test(selector)) ? '' : ';'
				styleSheet = styleSheet.sheet;
				propStr = Object.keys(props).reduce(
					(acc, cur) => {
						let sign;

						sign = /^\{.*\}$/.test(props[cur]) ? '' : ':';
						return acc.concat([`${cur}${sign}${props[cur]}`]);
					}
				, []).join(sign);
				findIndex = Array.from(styleSheet.cssRules).findIndex((rule) => rule.selectorText == selector);

				if (findIndex !== -1) {
					try {
						styleSheet.cssRules[findIndex].style.cssText = propStr;
					} catch(err) {}
				} else {
					try {
						styleSheet.insertRule(`${selector}{${propStr}}`, styleSheet.cssRules.length);
					} catch(err) {}
				}
			}
		}
	});
	
	window._wcl = _wcl;
})();