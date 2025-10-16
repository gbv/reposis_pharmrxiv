<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    exclude-result-prefixes="i18n mcrver mcrxsl">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />
  <xsl:param name="piwikID" select="'0'" />

  <xsl:template name="mir.navigation">

    <div id="header_box" class="clearfix container">

      <a
        id="project_logo_box"
        class="hidden-xs"
        href="{i18n:translate('project.href.goToMainSite')}"
        title="{i18n:translate('project.title.goToMainSite')}">
        <img
          src="{$WebApplicationBaseURL}images/logo-fid-pharmazie-500.jpg"
          alt="{i18n:translate('project.logoFidPharmazie')}" />
      </a>

      <div id="options_nav_box" class="mir-prop-nav">
        <nav>
          <ul class="navbar-nav ml-auto flex-row flex-row-reverse">
            <xsl:call-template name="mir.languageMenu" />
            <xsl:call-template name="mir.loginMenu" />
          </ul>
        </nav>
        <a id="ifis" href="https://www.tu-braunschweig.de/ifis">
          <span>ifis</span> | Institut für Informationssysteme
        </a>
        <a id="ubbs" href="http://www.ub.tu-braunschweig.de">
          Universitätsbibliothek Braunschweig
        </a>
      </div>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="mir-main-nav bg-primary">
      <div class="container">

        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
          <button
            class="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#mir-main-nav-collapse-box"
            aria-controls="mir-main-nav-collapse-box"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div id="mir-main-nav-collapse-box" class="collapse navbar-collapse mir-main-nav__entries">
            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
              <xsl:call-template name="project.generate_single_menu_entry">
                <xsl:with-param name="menuID" select="'brand'"/>
              </xsl:call-template>
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='topics']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
              <xsl:call-template name="mir.basketMenu" />
            </ul>
          </div>

          <form
            action="{$WebApplicationBaseURL}servlets/solr/find"
            class="bs-search form-inline searchfield_box"
            role="search">
            <input
              name="condQuery"
              placeholder="{i18n:translate('mir.navsearch.placeholder')}"
              class="form-control mr-sm-2 search-query"
              id="searchInput"
              type="text"
              aria-label="Search" />
            <xsl:choose>
              <xsl:when test="contains($isSearchAllowedForCurrentUser, 'true')">
                <input name="owner" type="hidden" value="createdby:*" />
              </xsl:when>
              <xsl:when test="not(mcrxsl:isCurrentUserGuestUser())">
                <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
              </xsl:when>
            </xsl:choose>
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-search"></i>
            </button>
          </form>

        </nav>
      </div>
    </div>

    <div id="digibib_feedback">
      <a href="mailto:digibib@tu-braunschweig.de">Feedback</a>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- do nothing special -->
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
      <div class="row">
        <div class="col-6 col-sm-9">
          <ul class="internal_links">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" mode="footerMenu" />
          </ul>
        </div>
        <div class="col-6 col-sm-3">
          <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
          <div id="powered_by">
            <a id="mycore_logo" href="http://www.mycore.de">
              <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_powered_120x30_blaue_schrift_frei.png" title="{$mcr_version}" alt="powered by MyCoRe" />
            </a>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="project.generate_single_menu_entry">
    <xsl:param name="menuID" />

    <xsl:variable name="activeClass">
      <xsl:choose>
        <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item[@href = $browserAddress ]">
        <xsl:text>active</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>not-active</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <li class="nav-item {$activeClass}">

      <a id="{$menuID}" href="{$WebApplicationBaseURL}{$loaded_navigation_xml/menu[@id=$menuID]/item/@href}" class="nav-link" >
        <xsl:choose>
          <xsl:when test="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)] != ''">
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($CurrentLang)]" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$loaded_navigation_xml/menu[@id=$menuID]/item/label[lang($DefaultLang)]" />
          </xsl:otherwise>
        </xsl:choose>
      </a>
    </li>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <script type="text/javascript" src="{$WebApplicationBaseURL}js/jquery.cookiebar.js"></script>
  </xsl:template>

</xsl:stylesheet>
