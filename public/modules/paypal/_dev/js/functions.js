//  Highlighting necessary block while click on link in header
export const hoverConfig = (el) => {

  // Remove highlighting from all blocks
	$('.defaultForm').removeClass('pp-settings-link-on');
  $('.page-head-tabs a').removeClass('pp-settings-link-on pp__border-b-primary');

  // Add highlighting for current block
  el.addClass('pp-settings-link-on');

  // Scroll to current block
  $('html, body').animate({
		scrollTop: el.offset().top - 200 + "px"
	}, 900);
}

//  Highlighting necessary tab while click on link in header
export const hoverTabConfig = () => {
  let tabs = document.querySelectorAll('.page-head-tabs a'),
		currentTab = $('.page-head-tabs a.current');
	tabs.forEach( el => {
		let checkoutTab = $(el).attr('href').includes('AdminPayPalCustomizeCheckout'),
		 	setupTab = $(el).attr('href').includes('AdminPayPalSetup');

    // Add highlighting for current tab
    if ((currentTab.attr('href').includes('AdminPayPalCustomizeCheckout') && setupTab)
			|| (currentTab.attr('href').includes('AdminPayPalSetup') && checkoutTab)) {
			$(el).addClass('pp-settings-link-on pp__border-b-primary');
		}
	})

  // Scroll to current tab
  $('html, body').animate({
		scrollTop: $('.page-head-tabs').offset().top - 200 + "px"
	}, 900);
}


// Show a block while choosing first option in current select, hide it while choosing others options
export const selectOption = (select, el) => {
	if (select) {
		select.on('change', (e) => {
			let index = e.target.selectedIndex;
			if (index == 0) {
				el.show();
			} else {
				el.hide();
			}
		})
	}
}
