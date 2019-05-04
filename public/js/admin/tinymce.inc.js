/**
 * Change default icons to marerial icons
 */
function changeToMaterial() {
  var materialIconAssoc = {
    'mce-i-code': '<i class="material-icons">code</i>',
    'mce-i-visualblocks': '<i class="material-icons">dashboard</i>', // suzy: 2018-09-14 調整設定檔
    'mce-i-none': '<i class="material-icons">format_color_text</i>',
    'mce-i-bold': '<i class="material-icons">format_bold</i>',
    'mce-i-italic': '<i class="material-icons">format_italic</i>',
    'mce-i-underline': '<i class="material-icons">format_underlined</i>',
    'mce-i-strikethrough': '<i class="material-icons">format_strikethrough</i>',
    'mce-i-blockquote': '<i class="material-icons">format_quote</i>',
    'mce-i-link': '<i class="material-icons">link</i>',
    'mce-i-alignleft': '<i class="material-icons">format_align_left</i>',
    'mce-i-aligncenter': '<i class="material-icons">format_align_center</i>',
    'mce-i-alignright': '<i class="material-icons">format_align_right</i>',
    'mce-i-alignjustify': '<i class="material-icons">format_align_justify</i>',
    'mce-i-bullist': '<i class="material-icons">format_list_bulleted</i>',
    'mce-i-numlist': '<i class="material-icons">format_list_numbered</i>',
    'mce-i-image': '<i class="material-icons">image</i>',
    'mce-i-table': '<i class="material-icons">grid_on</i>',
    'mce-i-media': '<i class="material-icons">video_library</i>',
    'mce-i-browse': '<i class="material-icons">attachment</i>',
    'mce-i-checkbox': '<i class="mce-ico mce-i-checkbox"></i>',
  };

  $.each(materialIconAssoc, function (index, value) {
    $('.' + index).replaceWith(value);
  });
}

function tinySetup(config) {
  if (typeof tinyMCE === 'undefined') {
    setTimeout(function() {
      tinySetup(config);
    }, 100);
    return;
  }

  if (!config) {
    config = {};
  }

  if (typeof config.editor_selector != 'undefined') {
    config.selector = '.' + config.editor_selector;
  }


  var default_config = {
    selector: ".rte",
    browser_spellcheck: true,

    // suzy: 2018-09-27 移除 autoresize 修正 scrolbar 消失問題
    //plugins: "align colorpicker link image filemanager table media placeholder advlist code table autoresize",
    plugins: "align colorpicker link image filemanager table media placeholder advlist code table visualblocks",

    // suzy: 2018-09-22 移動 link 的位置
    // toolbar1: "code,colorpicker,bold,italic,underline,strikethrough,blockquote,link,align,bullist,numlist,table,image,media,formatselect",
    toolbar1: "code,colorpicker,bold,italic,underline,strikethrough,blockquote,align,bullist,numlist,table,link,image,media,formatselect,visualblocks",
    toolbar2: "",
    external_filemanager_path: baseAdminDir + "filemanager/",
    filemanager_title: "File manager",
    external_plugins: {"filemanager": baseAdminDir + "filemanager/plugin.min.js"},
    language: iso_user,
    content_style : (lang_is_rtl === '1' ? "body {direction:rtl;}" : ""),
    skin: "prestashop",
    menubar: false,
    statusbar: false,
    relative_urls: false,
    convert_urls: false,
    entity_encoding: "raw",

    // suzy: 2018-09-14 調整設定檔 start
    // extended_valid_elements: "em[class|name|id],@[role|data-*|aria-*]",
    // valid_children: "+*[*]",
    valid_children: "+body[style|script|iframe|section],pre[iframe|section|script|div|p|br|span|img|style|h1|h2|h3|h4|h5],*[*]",
    valid_elements: "*[*]",
    force_p_newlines : false,
    cleanup: false,
    forced_root_block : false,
    // force_br_newlines : true,
    convert_urls: true,
    relative_urls: false,
    remove_script_host: false,
    apply_source_formatting: false,
    verify_html: false,
    height: 'auto',
    content_css: "/themes/simplicity/assets/css/theme.css,/themes/simplicity/assets/css/custom.css",
    // suzy: 2018-09-14 調整設定檔 end
    init_instance_callback: "changeToMaterial"

    // suzy: 2018-09-14 hide
    //  rel_list:[
    //    { title: 'nofollow', value: 'nofollow' }
    //  ]
  };

  $.each(default_config, function (index, el) {
    if (config[index] === undefined)
      config[index] = el;
  });

  // Change icons in popups
  $('body').on('click', '.mce-btn, .mce-open, .mce-menu-item', function () {
    changeToMaterial();
  });

  tinyMCE.init(config);
}
