/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs-test/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 119);
/******/ })
/************************************************************************/
/******/ ({

/***/ 0:
/***/ (function(module, exports) {

/* globals __VUE_SSR_CONTEXT__ */

// this module is a runtime utility for cleaner component module output and will
// be included in the final webpack user bundle

module.exports = function normalizeComponent (
  rawScriptExports,
  compiledTemplate,
  injectStyles,
  scopeId,
  moduleIdentifier /* server only */
) {
  var esModule
  var scriptExports = rawScriptExports = rawScriptExports || {}

  // ES6 modules interop
  var type = typeof rawScriptExports.default
  if (type === 'object' || type === 'function') {
    esModule = rawScriptExports
    scriptExports = rawScriptExports.default
  }

  // Vue.extend constructor export interop
  var options = typeof scriptExports === 'function'
    ? scriptExports.options
    : scriptExports

  // render functions
  if (compiledTemplate) {
    options.render = compiledTemplate.render
    options.staticRenderFns = compiledTemplate.staticRenderFns
  }

  // scopedId
  if (scopeId) {
    options._scopeId = scopeId
  }

  var hook
  if (moduleIdentifier) { // server build
    hook = function (context) {
      // 2.3 injection
      context =
        context || // cached call
        (this.$vnode && this.$vnode.ssrContext) || // stateful
        (this.parent && this.parent.$vnode && this.parent.$vnode.ssrContext) // functional
      // 2.2 with runInNewContext: true
      if (!context && typeof __VUE_SSR_CONTEXT__ !== 'undefined') {
        context = __VUE_SSR_CONTEXT__
      }
      // inject component styles
      if (injectStyles) {
        injectStyles.call(this, context)
      }
      // register component module identifier for async chunk inferrence
      if (context && context._registeredComponents) {
        context._registeredComponents.add(moduleIdentifier)
      }
    }
    // used by ssr in case component is cached and beforeCreate
    // never gets called
    options._ssrRegister = hook
  } else if (injectStyles) {
    hook = injectStyles
  }

  if (hook) {
    var functional = options.functional
    var existing = functional
      ? options.render
      : options.beforeCreate
    if (!functional) {
      // inject component registration as beforeCreate hook
      options.beforeCreate = existing
        ? [].concat(existing, hook)
        : [hook]
    } else {
      // register for functioal component in vue file
      options.render = function renderWithStyleInjection (h, context) {
        hook.call(context)
        return existing(h, context)
      }
    }
  }

  return {
    esModule: esModule,
    exports: scriptExports,
    options: options
  }
}


/***/ }),

/***/ 117:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/* harmony default export */ __webpack_exports__["a"] = ({
   props: ['values'],
   data: function data() {
      return {
         prefectures: this.values.prefecture_values,
         areas: this.values.area_values,
         text_values: [],
         hidden_values: [],
         selector_activated: false
      };
   },
   methods: {

      toggleSelector: function toggleSelector(event) {
         var input_tag = document.getElementsByClassName('location-selection')[0];
         var selector_tag = document.getElementsByClassName('search-location')[0];
         if (event.target == input_tag) {
            this.selector_activated = !this.selector_activated;
         } else if (!selector_tag.contains(event.target)) {
            this.selector_activated = false;
         }
      },
      isParent: function isParent(location) {
         if (location.constructor.name == "Prefecture") {
            return [location.value];
         } else {
            return location.cities;
         }
      },
      writeValuesOnForms: function writeValuesOnForms(location) {
         this.text_values.push(location.value);
         this.hidden_values.push(this.isParent(location));
         this.hidden_values = Array.prototype.concat.apply([], this.hidden_values);
      },
      eraseValuesOnForms: function eraseValuesOnForms(location) {
         var delete_idx = this.text_values.indexOf(location.value);
         if (delete_idx >= 0) {
            this.text_values.splice(delete_idx, 1);
            if (location.constructor.name == "Prefecture") {
               var delete_target = this.hidden_values.indexOf(location.value);
               this.hidden_values.splice(delete_target, 1);
            } else {
               var delete_target = this.hidden_values.indexOf(location.cities[0]);
               this.hidden_values.splice(delete_target, location.cities.length);
            }
         }
      },
      checkAllChildren: function checkAllChildren(location, location_tag) {
         if (location_tag.checked == true) {
            for (var i = 0; i < this.areas[location.tag_id].length; i++) {
               this.eraseValuesOnForms(this.areas[location.tag_id][i]);
            }
         }
         var children_tags = document.getElementsByClassName(location.tag_id);
         for (var i = 0; i < children_tags.length; i++) {
            children_tags[i].checked = location_tag.checked;
         }
      },
      checkRelatives: function checkRelatives(location, location_tag) {
         if (location_tag.checked == false) {
            var location_tag = document.getElementById(location.tag_id);
            var parent_tag = document.getElementById(location_tag.className);
            var delete_idx = this.text_values.indexOf(this.prefectures[parent_tag.id].value);
            this.eraseValuesOnForms(this.prefectures[parent_tag.id]);
            if (delete_idx >= 0) {
               parent_tag.checked = false;
               for (var i = 0; i < this.areas[parent_tag.id].length; i++) {
                  this.writeValuesOnForms(this.areas[parent_tag.id][i]);
               }
            }
         }
      },
      validateValue: function validateValue(location) {
         var location_tag = document.getElementById(location.tag_id);

         if (location.constructor.name == "Prefecture") {
            this.checkAllChildren(location, location_tag);
         } else {
            this.checkRelatives(location, location_tag);
         }

         if (location_tag.checked == true) {
            this.writeValuesOnForms(location);
         } else {
            this.eraseValuesOnForms(location);
         }
      }
   },
   created: function created() {
      window.addEventListener('click', this.toggleSelector);
   }
});

/***/ }),

/***/ 118:
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 119:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_search_address_tag_vue__ = __webpack_require__(117);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_75c4aed4_node_modules_vue_loader_lib_selector_type_template_index_0_search_address_tag_vue__ = __webpack_require__(120);
var disposed = false
function injectStyle (ssrContext) {
  if (disposed) return
  __webpack_require__(118)
}
var normalizeComponent = __webpack_require__(0)
/* script */

/* template */

/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = "data-v-75c4aed4"
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_lib_selector_type_script_index_0_search_address_tag_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_lib_template_compiler_index_id_data_v_75c4aed4_node_modules_vue_loader_lib_selector_type_template_index_0_search_address_tag_vue__["a" /* default */],
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)
Component.options.__file = "app/javascript/packs/vue/static_pages/area_selector_backup/search_address_tag.vue"
if (Component.esModule && Object.keys(Component.esModule).some(function (key) {return key !== "default" && key.substr(0, 2) !== "__"})) {console.error("named exports are not supported in *.vue files.")}
if (Component.options.functional) {console.error("[vue-loader] search_address_tag.vue: functional components are not supported with templates, they should use render functions.")}

/* hot reload */
if (false) {(function () {
  var hotAPI = require("vue-hot-reload-api")
  hotAPI.install(require("vue"), false)
  if (!hotAPI.compatible) return
  module.hot.accept()
  if (!module.hot.data) {
    hotAPI.createRecord("data-v-75c4aed4", Component.options)
  } else {
    hotAPI.reload("data-v-75c4aed4", Component.options)
  }
  module.hot.dispose(function (data) {
    disposed = true
  })
})()}

/* harmony default export */ __webpack_exports__["default"] = (Component.exports);


/***/ }),

/***/ 120:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('dd', [_c('input', {
    directives: [{
      name: "model",
      rawName: "v-model:value",
      value: (_vm.text_values),
      expression: "text_values",
      arg: "value"
    }],
    staticClass: "location-selection",
    attrs: {
      "readonly": "",
      "type": "text"
    },
    domProps: {
      "value": (_vm.text_values)
    },
    on: {
      "input": function($event) {
        if ($event.target.composing) { return; }
        _vm.text_values = $event.target.value
      }
    }
  }), _vm._v(" "), _c('input', {
    directives: [{
      name: "model",
      rawName: "v-model:value",
      value: (_vm.hidden_values),
      expression: "hidden_values",
      arg: "value"
    }],
    attrs: {
      "name": "search[locations]",
      "type": "hidden"
    },
    domProps: {
      "value": (_vm.hidden_values)
    },
    on: {
      "input": function($event) {
        if ($event.target.composing) { return; }
        _vm.hidden_values = $event.target.value
      }
    }
  }), _vm._v(" "), _c('div', {
    directives: [{
      name: "show",
      rawName: "v-show",
      value: (_vm.selector_activated),
      expression: "selector_activated"
    }],
    staticClass: "search-location"
  }, _vm._l((_vm.prefectures), function(prefecture) {
    return _c('dl', [_c('dt', [_c('input', {
      attrs: {
        "type": "checkbox",
        "id": prefecture.tag_id
      },
      domProps: {
        "value": prefecture.value
      },
      on: {
        "click": function($event) {
          _vm.validateValue(prefecture)
        }
      }
    }), _vm._v(" "), _c('label', {
      attrs: {
        "for": prefecture.tag_id
      }
    }, [_vm._v(_vm._s(prefecture.value))])]), _vm._v(" "), _vm._l((_vm.areas[prefecture.tag_id]), function(area) {
      return _c('dd', [_c('input', {
        class: prefecture.tag_id,
        attrs: {
          "type": "checkbox",
          "id": area.tag_id
        },
        domProps: {
          "value": area.value
        },
        on: {
          "click": function($event) {
            _vm.validateValue(area)
          }
        }
      }), _vm._v(" "), _c('label', {
        attrs: {
          "for": area.tag_id
        }
      }, [_vm._v(_vm._s(area.value))])])
    })], 2)
  }))])
}
var staticRenderFns = []
render._withStripped = true
/* harmony default export */ __webpack_exports__["a"] = ({ render: render, staticRenderFns: staticRenderFns });
if (false) {
  module.hot.accept()
  if (module.hot.data) {
     require("vue-hot-reload-api").rerender("data-v-75c4aed4", module.exports)
  }
}

/***/ })

/******/ });