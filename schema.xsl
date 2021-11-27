<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <xsl:output method="xhtml"/>
  <!-- Schema root -->
  <xsl:template match="/xsi:schema">
    <xsl:element name="html">
      <xsl:attribute name="lang">en</xsl:attribute>
      <xsl:element name="head">
        <xsl:element name="meta">
          <xsl:attribute name="name">viewport</xsl:attribute>
          <xsl:attribute name="content">width = device-width, initial-scale = 1</xsl:attribute>
        </xsl:element>
        <xsl:if test="xsi:annotation/xsi:appinfo">
          <xsl:element name="title">
            <xsl:value-of select="xsi:annotation/xsi:appinfo"/>
          </xsl:element>
        </xsl:if>
        <xsl:element name="link">
          <xsl:attribute name="rel">stylesheet</xsl:attribute>
          <xsl:attribute name="href">/main.css</xsl:attribute>
        </xsl:element>
        <xsl:element name="link">
          <xsl:attribute name="rel">stylesheet</xsl:attribute>
          <xsl:attribute name="href">/schema.css</xsl:attribute>
        </xsl:element>
      </xsl:element>
      <xsl:element name="body">
        <xsl:element name="header">
          <xsl:element name="hgroup">
            <xsl:element name="h1">
              <xsl:value-of select="xsi:annotation/xsi:appinfo"/>
            </xsl:element>
            <xsl:element name="p">
              <xsl:text>XSD </xsl:text>
              <xsl:value-of select="@version"/>
            </xsl:element>
          </xsl:element>
          <xsl:apply-templates select="xsi:annotation/xsi:documentation" mode="documentation"/>
        </xsl:element>
        <xsl:element name="main">
          <xsl:call-template name="attributes"/>
          <xsl:apply-templates select="xsi:*"/>
        </xsl:element>
        <xsl:if test="not(xsi:annotation/xsi:appinfo)">
          <xsl:element name="script">
            <xsl:text>document.querySelector("h1").innerText = location.pathname;</xsl:text>
          </xsl:element>
        </xsl:if>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <!-- Elements -->
  <xsl:template match="xsi:annotation"/>
  <xsl:template match="xsi:documentation" mode="documentation">
    <xsl:element name="p">
      <xsl:attribute name="class">documentation</xsl:attribute>
      <xsl:value-of select="text()"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:*">
    <xsl:element name="details">
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
        <xsl:if test="not(*[not(name() = 'annotation')])">
          <xsl:text> locked</xsl:text>
        </xsl:if>
      </xsl:attribute>
      <xsl:if test="not(*[not(name() = 'annotation')])">
        <xsl:attribute name="open">open</xsl:attribute>
      </xsl:if>
      <xsl:element name="summary">
        <xsl:apply-templates select="." mode="heading"/>
      </xsl:element>
      <xsl:call-template name="attributes"/>
      <xsl:apply-templates select="xsi:*"/>
    </xsl:element>
  </xsl:template>
  <!-- Element headings -->
  <xsl:template match="xsi:element[@name]" mode="heading">
    <xsl:text>element </xsl:text>
    <xsl:element name="code">
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>&gt;</xsl:text>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:element[@ref]" mode="heading">
    <xsl:text>element &#x2192; </xsl:text>
    <xsl:element name="code">
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="@ref"/>
      <xsl:text>&gt;</xsl:text>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:attribute[@name]" mode="heading">
    <xsl:text>attribute </xsl:text>
    <xsl:element name="code">
      <xsl:text>@</xsl:text>
      <xsl:value-of select="@name"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:attribute[@ref]" mode="heading">
    <xsl:text>attribute &#x2192; </xsl:text>
    <xsl:element name="code">
      <xsl:text>@</xsl:text>
      <xsl:value-of select="@ref"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:group[@name]|xsi:attributeGroup[@name]" mode="heading">
    <xsl:value-of select="name()"/>
    <xsl:text> </xsl:text>
    <xsl:element name="q">
      <xsl:value-of select="@name"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:group[@ref]|xsi:attributeGroup[@ref]" mode="heading">
    <xsl:value-of select="name()"/>
    <xsl:text> &#x2192; </xsl:text>
    <xsl:element name="q">
      <xsl:value-of select="@ref"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:complexType[@name]|xsi:simpleType[@name]|xsi:unique" mode="heading">
    <xsl:value-of select="name()"/>
    <xsl:text> </xsl:text>
    <xsl:element name="q">
      <xsl:value-of select="@name"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:*" mode="heading">
    <xsl:value-of select="name()"/>
  </xsl:template>
  <!-- Attributes wrapper -->
  <xsl:template name="attributes">
    <xsl:if test="@*">
      <xsl:element name="div">
        <xsl:attribute name="class">attributes</xsl:attribute>
        <xsl:apply-templates select="@*"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <!-- Attributes -->
  <xsl:template match="@*">
    <xsl:element name="p">
      <xsl:element name="strong">
        <xsl:text>@</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>:</xsl:text>
      </xsl:element>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="." mode="value"/>
    </xsl:element>
  </xsl:template>
  <!-- Attribute values -->
  <xsl:template match="@namespace|@schemaLocation|@targetNamespace" mode="value">
    <xsl:element name="a">
      <xsl:attribute name="href">
        <xsl:value-of select="."/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="@xpath|@test|xsi:pattern/@value" mode="value">
    <xsl:element name="code">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="@name|@ref|@substitutionGroup|@type|@itemType|@refer|@base|xsi:enumeration/@value" mode="value">
    <xsl:element name="q">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="@*" mode="value">
    <xsl:value-of select="."/>
  </xsl:template>
</xsl:stylesheet>
