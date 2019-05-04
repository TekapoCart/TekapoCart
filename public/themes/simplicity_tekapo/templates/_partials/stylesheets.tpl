<link href="https://fonts.googleapis.com/css?family=Noto+Sans+TC:300,400" rel="stylesheet">

{foreach $stylesheets.external as $stylesheet}
    <link rel="stylesheet" href="{$stylesheet.uri}?{$smarty.const._TC_VERSION_DATE_}" type="text/css" media="{$stylesheet.media}">
{/foreach}

{foreach $stylesheets.inline as $stylesheet}
    <style>
        {$stylesheet.content}
    </style>
{/foreach}
