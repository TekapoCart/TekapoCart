<button type="button"
        onclick="window.open('{{$map_url}}', '_self');"
        class="btn btn-primary">{{$map_title}}</button>

{if $store_data}
    {$store_data['stCate']}<br>
    {$store_data['stCode']}<br>
    {$store_data['stName']}<br>
    {$store_data['stAddr']}<br>
{/if}