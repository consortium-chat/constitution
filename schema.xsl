<?xml version="1.0" encoding="UTF-8"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="1.0">
  <output method="xhtml"/>
  <!-- Schema root -->
  <template match="/xsd:schema">
    <element name="xhtml:html">
      <attribute name="lang">en</attribute>
      <element name="xhtml:head">
        <element name="xhtml:meta">
          <attribute name="name">viewport</attribute>
          <attribute name="content">width = device-width, initial-scale = 1</attribute>
        </element>
        <if test="xsd:annotation/xsd:appinfo">
          <element name="xhtml:title">
            <value-of select="xsd:annotation/xsd:appinfo"/>
          </element>
        </if>
        <element name="xhtml:link">
          <attribute name="rel">stylesheet</attribute>
          <attribute name="href">/main.css</attribute>
        </element>
        <element name="xhtml:link">
          <attribute name="rel">stylesheet</attribute>
          <attribute name="href">/schema.css</attribute>
        </element>
      </element>
      <element name="xhtml:body">
        <element name="xhtml:header">
          <element name="xhtml:hgroup">
            <element name="xhtml:h1">
              <value-of select="xsd:annotation/xsd:appinfo"/>
            </element>
            <element name="xhtml:p">
              <text>XSD </text>
              <value-of select="@version"/>
            </element>
          </element>
          <apply-templates select="xsd:annotation/xsd:documentation" mode="documentation"/>
        </element>
        <element name="xhtml:main">
          <call-template name="attributes"/>
          <apply-templates select="xsd:*"/>
        </element>
        <if test="not(xsd:annotation/xsd:appinfo)">
          <element name="xhtml:script">
            <text>document.querySelector("h1").innerText = location.pathname;</text>
          </element>
        </if>
      </element>
    </element>
  </template>
  <!-- Elements -->
  <template match="xsd:annotation"/>
  <template match="xsd:documentation" mode="documentation">
    <element name="xhtml:p">
      <attribute name="class">documentation</attribute>
      <value-of select="text()"/>
    </element>
  </template>
  <template match="xsd:*">
    <element name="xhtml:details">
      <attribute name="class">
        <value-of select="name()"/>
        <if test="not(*[not(name() = 'annotation')])">
          <text> locked</text>
        </if>
      </attribute>
      <if test="not(*[not(name() = 'annotation')])">
        <attribute name="open">open</attribute>
      </if>
      <element name="xhtml:summary">
        <apply-templates select="." mode="heading"/>
      </element>
      <apply-templates select="xsd:annotation/xsd:documentation" mode="documentation"/>
      <call-template name="attributes"/>
      <apply-templates select="xsd:*"/>
    </element>
  </template>
  <!-- Element headings -->
  <template match="xsd:element[@name]" mode="heading">
    <text>element </text>
    <element name="xhtml:code">
      <text>&lt;</text>
      <value-of select="@name"/>
      <text>&gt;</text>
    </element>
  </template>
  <template match="xsd:element[@ref]" mode="heading">
    <text>element &#x2192; </text>
    <element name="xhtml:code">
      <text>&lt;</text>
      <value-of select="@ref"/>
      <text>&gt;</text>
    </element>
  </template>
  <template match="xsd:attribute[@name]" mode="heading">
    <text>attribute </text>
    <element name="xhtml:code">
      <text>@</text>
      <value-of select="@name"/>
    </element>
  </template>
  <template match="xsd:attribute[@ref]" mode="heading">
    <text>attribute &#x2192; </text>
    <element name="xhtml:code">
      <text>@</text>
      <value-of select="@ref"/>
    </element>
  </template>
  <template match="xsd:group[@name]|xsd:attributeGroup[@name]" mode="heading">
    <value-of select="name()"/>
    <text> </text>
    <element name="xhtml:q">
      <value-of select="@name"/>
    </element>
  </template>
  <template match="xsd:group[@ref]|xsd:attributeGroup[@ref]" mode="heading">
    <value-of select="name()"/>
    <text> &#x2192; </text>
    <element name="xhtml:q">
      <value-of select="@ref"/>
    </element>
  </template>
  <template match="xsd:complexType[@name]|xsd:simpleType[@name]|xsd:unique" mode="heading">
    <value-of select="name()"/>
    <text> </text>
    <element name="xhtml:q">
      <value-of select="@name"/>
    </element>
  </template>
  <template match="xsd:*" mode="heading">
    <value-of select="name()"/>
  </template>
  <!-- Attributes wrapper -->
  <template name="attributes">
    <if test="@*">
      <element name="xhtml:div">
        <attribute name="class">attributes</attribute>
        <apply-templates select="@*"/>
      </element>
    </if>
  </template>
  <!-- Attributes -->
  <template match="@*">
    <element name="xhtml:p">
      <element name="xhtml:strong">
        <text>@</text>
        <value-of select="name()"/>
        <text>:</text>
      </element>
      <text> </text>
      <apply-templates select="." mode="value"/>
    </element>
  </template>
  <!-- Attribute values -->
  <template match="@namespace|@schemaLocation|@targetNamespace" mode="value">
    <element name="xhtml:a">
      <attribute name="href">
        <value-of select="."/>
      </attribute>
      <value-of select="."/>
    </element>
  </template>
  <template match="@xpath|@test|xsd:pattern/@value" mode="value">
    <element name="xhtml:code">
      <value-of select="."/>
    </element>
  </template>
  <template match="@name|@ref|@substitutionGroup|@type|@itemType|@refer|@base|xsd:enumeration/@value" mode="value">
    <element name="xhtml:q">
      <value-of select="."/>
    </element>
  </template>
  <template match="@*" mode="value">
    <value-of select="."/>
  </template>
</stylesheet>
