<cfcomponent name="tooltip">
	<cfset this.metadata.attributetype="mixed">
	<cfset this.metadata.attributes={
		// Standard CFML attributes that match Adobe CF
		tooltip:		{required:true,type:"string"},
		loadJquery:		{required:false,type:"boolean",default:0}
	}/>
	<cffunction name="init" output="no" returntype="void" hint="invoked after tag is constructed">
		<cfargument name="hasEndTag" type="boolean" required="yes" />
		<cfargument name="parent" type="component" required="no" hint="the parent cfc custom tag, if there is one" />
		<cfset variables.hasEndTag = arguments.hasEndTag />
	</cffunction>
	<cffunction name="onStartTag" output="yes" returntype="boolean">

		<cfargument name="attributes" type="struct">
		<cfargument name="caller" type="struct">

		<cfif structKeyExists(attributes,"argumentCollection")>
			<cfset arguments.attributes = attributes.argumentCollection />
		</cfif>

		<!--- this sets the defaults for undefined attributes.  Not sure why this is needed. --->
		<cfset variables.attributes=setAttributes(arguments.attributes) />

		<cfif not variables.hasEndTag>
			<cfset onEndTag(variables.attributes,caller,"") />
		</cfif>

		<cfreturn variables.hasEndTag>
	</cffunction>
	<cffunction name="onEndTag" output="yes" returntype="boolean">

		<cfargument name="attributes" type="struct">
		<cfargument name="caller" type="struct">
		<cfargument name="generatedContent" type="string">

		<!--- <cfset thistip = createUUID() /> --->
		<cfparam name="request.cftooltiploaded" default="0" />
		<cfparam name="request.jqueryloaded" default="0" />

		<div class="cftooltip">#arguments.generatedContent#</div>
		<div style="display:none;">
		    #encodeForHTML(attributes.tooltip)#
		</div>

		<cfif attributes.loadJquery AND request.jqueryloaded Neq 1>
			<cfhtmlbody text='<script src="//code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>' />
		</cfif>
		<cfset request.jqueryloaded = 1 />

		<cfif NOT request.cftooltiploaded>
			<cfsavecontent variable="footjs">
				<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/qtip2/3.0.3/jquery.qtip.min.css" />

				<script type="text/javascript" src="//cdn.jsdelivr.net/qtip2/3.0.3/jquery.qtip.min.js"></script>
				<script>
			       $('.cftooltip').each(function() { 
					    $(this).qtip({
					        content: {
					            text: $(this).next('div') // Use the "div" element next to this for the content
					        },
						    style: {
						        classes: 'qtip-light qtip-shadow'
						    },
						    position: {
						        my: 'bottom left',  // Position my top left...
						        at: 'top left'
						    }
					    });
					});
			    </script>
			</cfsavecontent>
			<cfhtmlbody text="#footjs#" />
			<cfset request.cftooltiploaded = 1 />
		</cfif>

		<cfreturn false/>
	</cffunction>

	<cffunction name="setAttributes" output="false" access="public" returntype="struct">
		<cfargument name="attributes" required="true" type="struct" />
		<cfloop collection="#this.metadata.attributes#" index="a">
			<cfif NOT structKeyExists(arguments.attributes,a)>
				<cfif structKeyExists(this.metadata.attributes[a],'default')>
					<cfset arguments.attributes[a] = this.metadata.attributes[a]['default'] />
				</cfif>	
			</cfif> 
		</cfloop>
		<cfreturn arguments.attributes />
    </cffunction>
</cfcomponent>
