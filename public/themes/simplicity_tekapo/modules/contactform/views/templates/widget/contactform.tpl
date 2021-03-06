<section class="contact-form">
  <form id="contact-form" action="{$urls.pages.contact}" method="post" {if $contact.allow_file_upload}enctype="multipart/form-data"{/if}>

    {if $notifications}
      <div class="col-xs-12 alert {if $notifications.nw_error}alert-danger{else}alert-success{/if}">
        <ul>
          {foreach $notifications.messages as $notif}
            <li>{$notif}</li>
          {/foreach}
        </ul>
      </div>
    {/if}

    {if !$notifications || $notifications.nw_error}
      <section class="form-fields">

        <div class="form-group row text-xs-center">
          <div class="col-md-12">
            {*<h3>{l s='Contact us' d='Shop.Theme.Global'}</h3>*}
            <h3>與 TekapoCart 聯絡</h3>
            <p>透過 E-Mail 獲得所需要的協助。</p>
          </div>
        </div>

        <div class="form-group row">
          <label class="col-md-3 form-control-label">{l s='Subject' d='Shop.Forms.Labels'}</label>
          <div class="col-md-6">
            <select name="id_contact" class="form-control form-control-select">
              {foreach from=$contact.contacts item=contact_elt}
                <option value="{$contact_elt.id_contact}">{$contact_elt.name}</option>
              {/foreach}
            </select>
          </div>
        </div>

        <div class="form-group row">
          <label class="col-md-3 form-control-label">{l s='Email address' d='Shop.Forms.Labels'}</label>
          <div class="col-md-6">
            <input
              class="form-control"
              name="from"
              type="email"
              value="{$contact.email}"
              placeholder="{l s='your@email.com' d='Shop.Forms.Help'}"
            >
          </div>
        </div>

        {if $contact.orders}
          <div class="form-group row">
            <label class="col-md-3 form-control-label">{l s='Order reference' d='Shop.Forms.Labels'}</label>
            <div class="col-md-6">
              <select name="id_order" class="form-control form-control-select">
                <option value="">{l s='Select reference' d='Shop.Forms.Help'}</option>
                {foreach from=$contact.orders item=order}
                  <option value="{$order.id_order}">{$order.reference}</option>
                {/foreach}
              </select>
            </div>
            <span class="col-md-3 form-control-comment">
              {l s='optional' d='Shop.Forms.Help'}
            </span>
          </div>
        {/if}

        {if $contact.allow_file_upload}
          <div class="form-group row">
            <label class="col-md-3 form-control-label">{l s='Attachment' d='Shop.Forms.Labels'}</label>
            <div class="col-md-6">
              <input type="file" name="fileUpload" class="filestyle" data-buttonText="{l s='Choose file' d='Shop.Theme.Actions'}">
            </div>
            <span class="col-md-3 form-control-comment">
              {l s='optional' d='Shop.Forms.Help'}
            </span>
          </div>
        {/if}

        <div class="form-group row">
          <label class="col-md-3 form-control-label">{l s='Message' d='Shop.Forms.Labels'}</label>
          <div class="col-md-6">
            <textarea
              class="form-control"
              name="message"
              placeholder="{l s='How can we help?' d='Shop.Forms.Help'}"
              rows="3"
            >{if $contact.message}{$contact.message}{/if}</textarea>
          </div>
        </div>

        {if isset($id_module)}
          <div class="form-group row">
            <div class="offset-md-3">
              {hook h='displayGDPRConsent' id_module=$id_module}
            </div>
          </div>
        {/if}

      </section>

      <footer class="form-footer text-sm-center">
        <style>
          input[name=url] {
            display: none !important;
          }
        </style>
        <input type="text" name="url" value=""/>
        <input type="hidden" name="token" value="{$token}" />
        {if strlen($recaptcha_key) > 0 }
        <input class="btn btn-primary g-recaptcha"
               data-sitekey="{$recaptcha_key}"
               data-callback="onSubmit"
               data-action="submit"
               type="submit" name="submitMessage" value="{l s='Send' d='Shop.Theme.Actions'}">
        {else}
        <input class="btn btn-primary" type="submit" name="submitMessage" value="{l s='Send' d='Shop.Theme.Actions'}">
        {/if}
      </footer>
    {/if}

  </form>
</section>

{if strlen($recaptcha_key) > 0 }
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script>
    function onSubmit(token) {
        document.getElementById("contact-form").submit();
    }
</script>
{/if}