# cftooltip-lucee
CFTOOLTIP for Lucee

This is a replacement for cftooltip for Lucee servers. The intention of this tag is to prevent the need to go edit every place that you used cftooltip on a server that used to be Adobe CF. Only the most basic features of cftooltip are implemented.

Why? I had a set of servers with hundreds of websites on them. They were all being converted from Adobe ColdFusion to Lucee. Rather than edit hundreds of files to remove cftooltip, I created this replacement tag.

## What it does not do...

This tag will not do binding (Ajax) or styling like the Adobe version.

## Installation

Place tooltip.cfc in your library/tag folder. You can do this at the server or context/site level. ('/lucee-server/context/library' for server, or '/WEB-INF/lucee/library' for a single site/context)

## Usage

You use this just like the regular CFTOOLTIP tag in Adobe ColdFusion (http://cfdocs.org/cftooltip).

## Supported Attributes
```html
tooltip:			{required:true,type:"string"}
```

## Examples
```html
 <cftooltip 
  tooltip="Here is my tooltip."
  >
  <a href="/">My Link</a>
 </cftooltip>
```

