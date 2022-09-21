<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- This script creates a box plot showing the distributions of sentence lengths 
    in the five parts of Roberto Bolaño's novel 2666. 
    The input file for this script is an XML/TEI file of the novel with linguistic annotation,
    created with the software FreeLing and with custom Python scripts to integrate the annotation into TEI.
    
    @author: Ulrike Henny-Krahmer
    -->
    
    
    <xsl:template match="/">
        
        <xsl:result-document method="html" encoding="UTF-8" href="sentence-lengths.html">
            <html>
                <head>
                    <!-- Plotly.js -->
                    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                </head>
                <body>
                    <!-- Plotly chart will be drawn inside this DIV -->
                    <div id="myDiv" style="width: 700px; height: 600px;"></div>
                    <script>
                        <xsl:for-each select="//div[@type='part']">
                            var trace<xsl:value-of select="position()"/> = {
                            y: [<xsl:for-each select=".//s">
                                <xsl:variable name="num-words" select="count(w)"/>
                                <!--<xsl:if test="$num-words &lt;= 100">-->
                                    <xsl:value-of select="$num-words"/>
                                    <xsl:if test="position()!=last()">,</xsl:if>
                                <!--</xsl:if>-->
                            </xsl:for-each>],
                            type: 'box',
                            boxmean: 'sd',
                            <!--boxpoints: 'all',-->
                            name: '<xsl:value-of select="position()"/>a parte'
                            };
                        </xsl:for-each>
                        
                        var data = [<xsl:for-each select="//div[@type='part']">
                            trace<xsl:value-of select="position()"/>
                            <xsl:if test="position()!=last()">,</xsl:if>
                        </xsl:for-each>];
                        var layout = {
                        font: {size: 18},
                        yaxis: {title: "longitud oracional en tokens", type: "log", autorange: true},
                        showlegend: false
                        };
                        
                        Plotly.newPlot('myDiv', data, layout);
                    </script>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
</xsl:stylesheet>