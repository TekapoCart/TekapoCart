<div class="tab-pane" id="smilepay_ezcatup_order_info">    {if NOT $track_num OR NOT $smse_id}
    <form action="{$action}" method="POST">
     
        <span>{l s='Package Size' mod='smilepay_ezcatup'}
            <input type="text" name="sp_length" maxlength="6" style="width: 35px;display: inline-block;" id="smilepayezcatup_length"  /> X
            <input type="text" name="sp_width" maxlength="6" style="width: 35px;display: inline-block;" id="smilepayezcatup_width" /> X
            <input type="text" name="sp_height" maxlength="6" style="width: 35px;display: inline-block;" id="smilepayezcatup_height" /> 
            <span>{l s='Unit cm' mod='smilepay_ezcatup'}<span>
        </span><br><br>
        <input type="hidden" name="order_id" value="{$order_id}"/>        <input type="submit"  onclick="return checkSmilepayEzcatupForm();" id="smilepayezcatup_btn_submit" value="{l s='Create Order' mod='smilepay_ezcatup'}">            </form>
    {else}            <div>                <h3>{l s='Smilepay id' mod='smilepay_ezcatup'} : <strong>{$smse_id}</strong><br></h3>                <h3>{l s='track num' mod='smilepay_ezcatup'} : <strong>{$track_num}</strong><br></h3>            </div>    {/if}
    <div>
        <p>
            <strong style="font-size: 16px;">{l s='note:' mod='smilepay_ezcatup'}</strong><br>
            <span style="margin-left: 40px;">{l s='Go to SmilePay platform print the shipping track list before you want to ship.' mod='smilepay_ezcatup'}</span><br>
            <span style="margin-left: 40px;">{l s='Finish process in 14 days when creating order' mod='smilepay_ezcatup'}</span><br>
            <span style="margin-left: 40px;">{l s='Set your ezcat info in SmilePay platform before you create order.' mod='smilepay_ezcatup'}</span>
        </p>
    </div>
</div>


<script type="text/javascript">
   
        function checkSmilepayEzcatupForm() {
       
            //var $=j2store.jQuery;
    
            var sp_length = $("#smilepayezcatup_length").val();
    
            var sp_width = $("#smilepayezcatup_width").val();
            var sp_height = $("#smilepayezcatup_height").val();
            var error_lwh = "{l s='LWH is ERROR Format' mod='smilepay_ezcatup'}";
            var lwh_sum = 0;
            var shippingcode = "{$shipping_code}";

            
            if (CheckDecimal(sp_length) && CheckDecimal(sp_width) && CheckDecimal(sp_height))
            {
                lwh_sum = parseInt( Math.round(parseFloat(sp_length) + parseFloat(sp_width) + parseFloat(sp_height)));
           

                if(shippingcode == "fridge" || shippingcode == "freeze")
                {
                    if(lwh_sum > 120)
                    {
                        alert("{l s='LWH is ERROR Size' mod='smilepay_ezcatup'}");
                        return false;
                    }
                } 
                else
                {
                    if(lwh_sum > 150)
                    {
                        alert("{l s='LWH is ERROR Size' mod='smilepay_ezcatup'}");
                        return false;
                    }
                }
            }
            else
            {
                alert(error_lwh);
                return false;
            }
            
            $("#smilepayezcatup_btn_submit").hide();
            return true;
        }

        function CheckDecimal(inputtxt) {
            var format_decimal = /[0-9]+(|.[0-9]+)$/;
   
            if (inputtxt != null && inputtxt.match(format_decimal)){
                return true;
            }
            else {
                return false;
            }
        }   
    </script>


