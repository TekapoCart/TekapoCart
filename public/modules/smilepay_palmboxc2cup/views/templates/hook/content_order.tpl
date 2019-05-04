<div class="tab-pane" id="smilepay_palmboxc2cup_order_info">    {if $sp_storeid or $sp_storename or $sp_storeaddress}
                <div>
                    {l s='storeid' mod='smilepay_palmboxc2cup'}:<strong style="margin-left:10px;color: blue;">{$sp_storeid}</strong><br>
                    {l s='storename' mod='smilepay_palmboxc2cup'}:<strong style="margin-left:10px;color: blue;">{$sp_storename}</strong><br>
                    {l s='storeaddress' mod='smilepay_palmboxc2cup'}:<strong style="margin-left:10px;color: blue;">{$sp_storeaddress}</strong><br>
                </div><br>
    {else}
                <div>
                     {l s='Not selected convenience store,re-created in Smilepay website.' mod='smilepay_palmboxc2cup'}
                </div><br>
    {/if}    {if NOT $checkcode OR NOT $smse_id}
    <form action="{$action}" method="POST">
        
        <span style="font-size: 16px;">{l s='Box Size' mod='smilepay_palmboxc2cup'}:</span>
            <select name="sp_size" id="smilepaypalmboxc2cup_size">
                  <option value="1">{l s='small' mod='smilepay_palmboxc2cup'}(9x34x41)</option>
                  <option value="2">{l s='medium' mod='smilepay_palmboxc2cup'}(20x34x41)</option>
                  <option value="3">{l s='large' mod='smilepay_palmboxc2cup'}(31x34x41)</option>
            </select>
            <span>{l s='Unit: cm' mod='smilepay_palmboxc2cup'}</span><br>
            
            
       <br>
        <input type="hidden" name="order_id" value="{$order_id}"/>        <input type="submit"  onclick="return checkSmilepayPalmboxc2cupForm();" id="smilepaypalmboxc2cup_btn_submit" value="{l s='Create Order' mod='smilepay_palmboxc2cup'}">        <br> <br>    </form>
    {else}            <div>                <h3>{l s='Smilepay id' mod='smilepay_palmboxc2cup'} : <strong>{$smse_id}</strong><br></h3>                <h3>{l s='checkcode num' mod='smilepay_palmboxc2cup'} : <strong>{$checkcode}</strong><br></h3>            </div>    {/if}
    <div>
        <p>
            <strong style="font-size: 16px;">{l s='note:' mod='smilepay_palmboxc2cup'}</strong><br>
            <span style="margin-left: 40px;">{l s='It is different shipping cost with box size.' mod='smilepay_palmboxc2cup'}</span><br>
            <span style="margin-left: 40px;">{l s='Please ship within 24 hours after you create order' mod='smilepay_palmboxc2cup'}</span><br>
            <span style="margin-left: 40px;">{l s='If box is full, you can use the code to others box' mod='smilepay_palmboxc2cup'}</span>
        </p>
    </div>
</div>


<script type="text/javascript">
   
        function checkSmilepayPalmboxc2cupForm() {
       
            //var $=j2store.jQuery;
    
            var sp_size = $("#smilepaypalmboxc2cup_size").val();
    
           
            var lwh_sum = 0;
            var shippingcode = "{$shipping_code}";

            
            $("#smilepaypalmboxc2cup_btn_submit").hide();
            return true;
        }

        
    </script>


