<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    
    <!-- This script creates a column chart showing the proportion of tokens with direct speech and other text 
    in the five parts of Roberto Bolaño's novel 2666. 
    The input file for this script is an XML/TEI file of the novel with direct speech mark-up.
    
    @author: Ulrike Henny-Krahmer
    -->
    
    <xsl:template match="/">
        
        
        <xsl:result-document method="html" encoding="UTF-8" href="said.html">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 600px;"></div>
                    <script>
                        
                        
                        
                        var trace1 = {
                        
                        x: [<xsl:for-each select="//div[@type='part']">
                            '<xsl:value-of select="position()"/>a parte'
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>],
                        
                        y: [<xsl:for-each select="//div[@type='part']">
                            <xsl:variable name="tokens-speech" select="count(.//p[said[contains(.,'–') or contains(.,'«') or contains(.,'»')]]//said[not(@direct='false') and not(@aloud='false')]/tokenize(.,'\s')[normalize-space(.)!=''])"/>
                            <xsl:value-of select="$tokens-speech"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>],
                        
                        name: 'discurso directo (marcado)',
                        
                        type: 'bar'
                        
                        };
                        
                        
                        
                        var trace2 = {
                        
                        x: [<xsl:for-each select="//div[@type='part']">
                            '<xsl:value-of select="position()"/>a parte'
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>],
                        
                        y: [<xsl:for-each select="//div[@type='part']">
                            <xsl:variable name="tokens" select="count(tokenize(.,'\s')[normalize-space(.)!=''])"/>
                            <xsl:variable name="tokens-speech" select="count(.//p[said[contains(.,'–') or contains(.,'«') or contains(.,'»')]]//said[not(@direct='false') and not(@aloud='false')]/tokenize(.,'\s')[normalize-space(.)!=''])"/>
                            <xsl:value-of select="$tokens - $tokens-speech"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>],
                        
                        name: 'otro texto',
                        
                        type: 'bar'
                        
                        };
                        
                        
                        var data = [trace1, trace2];
                        
                        
                        var layout = {
                            barmode: 'stack',
                            yaxis: {title: "número de tokens"},
                            font: {size: 16},
                            annotations: [
                                <xsl:for-each select="//div[@type='part']">
                                    {
                                    <xsl:variable name="tokens" select="count(tokenize(.,'\s')[normalize-space(.)!=''])"/>
                                    <xsl:variable name="tokens-speech" select="count(.//p[said[contains(.,'–') or contains(.,'«') or contains(.,'»')]]//said[not(@direct='false') and not(@aloud='false')]/tokenize(.,'\s')[normalize-space(.)!=''])"/>
                                    x: <xsl:value-of select="position() - 1.2"/>,
                                    y: <xsl:value-of select="$tokens-speech"/>,
                                    text: "<xsl:value-of select="ceiling(($tokens-speech div $tokens) * 100)"/><xsl:text>%</xsl:text>",
                                    showarrow: false,
                                    xanchor: "left",
                                    yanchor: "bottom",
                                    font: {size: 16}
                                    }
                                    <xsl:if test="position()!=last()">,</xsl:if>
                                </xsl:for-each>
                            ]
                            };
                        
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    
</xsl:stylesheet>
