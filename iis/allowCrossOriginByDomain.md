# Allow Cross-Origin by Domain

The following will set the CORS policy to allow other specific domains to request resources. This is useful when browsing sites with multiple domains that don't specify a CORS policy, don't redirect to a canonical URL, and are being browsed using Chrome 52+ (see https://bugs.chromium.org/p/chromium/issues/detail?id=633729). This is due to an empty header in a preflight request that will lock down the use of resources to the same origin when `X-FRAME-OPTIONS` is also set to `SAMEORIGIN`. When using IIS this can be done withing .NET code by defining a service policy, or it can be done in the `web.config` such as below.

*web.config*
```iis
<system.webServer>
  <httpProtocol>
    <customHeaders>
      <add name="Access-Control-Allow-Headers" value="Origin, X-Requested-With, Content-Type, Accept" />
      <add name="Access-Control-Allow-Methods" value="POST,GET,OPTIONS,PUT,DELETE" />
    </customHeaders>
  </httpProtocol>
  
  <rewrite>
    <outboundRules>
      <rule name="AddCrossDomainHeader">
        <match serverVariable="RESPONSE_Access_Control_Allow_Origin" pattern="\.(ttf|otf|eot|woff|css|js)$" />
        <conditions logicalGrouping="MatchAll" trackAllCaptures="true">
          <add input="{HTTP_ORIGIN}" pattern="http(s)?://(www\.)?(my-domain\.co\.uk|my-other-domain\.co\.uk)" />
        </conditions>
        <action type="Rewrite" value="{C:0}" />
      </rule>
    </outboundRules>
  </rewrite>
</system.webserver>
```

The above covers this for IIS, but similar can also be done for [Apache HTTPD](../apache-httpd/allowCrossOriginByDomain.md). A good resource for reading more on CORS policies is https://enable-cors.org/
