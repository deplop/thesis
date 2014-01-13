<?xml version="1.0" encoding="UTF-8"?>
<!-- Edited by XMLSpy® -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output omit-xml-declaration="yes" method="xml" version="1.0" />
<xsl:template match="recipe">
       <xsl:param name="region_id"><xsl:number/></xsl:param>
       INSERT INTO tbl_region VALUES(<xsl:value-of select="$region_id"/>,'<xsl:value-of select="name"/>','');
       <xsl:for-each select="prefectures/prefecture">
             <xsl:variable name="prefecture_id" select="position()"/>
             INSERT INTO tbl_prefecture VALUES(<xsl:value-of select="$region_id*10+$prefecture_id"/>,'<xsl:value-of select="."/>',<xsl:value-of select="$region_id"/>,'');
           
  
      </xsl:for-each>
      
   
</xsl:template>
<xsl:template match="text()"/>
</xsl:stylesheet>

