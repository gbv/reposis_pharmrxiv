<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:mcri18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="mcri18n">

  <xsl:template match="main-search-form">
    <form
      role="search"
      id="project-searchMainPage"
      class="form-inline mt-3"
      action="../servlets/solr/find"
    >
      <div class="input-group w-100">
        <input
          name="condQuery"
          placeholder="{mcri18n:translate('project.index_search.placeholder.default')}"
          class="form-control search-query"
          id="project-searchInput"
          type="text" />
        <div class="input-group-append">
          <button type="submit" class="btn text-primary bg-white">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
    </form>
  </xsl:template>

  <xsl:template match="contact-form">
    <form
      role="form"
      method="post"
      class="form-horizontal needs-validation"
      action="../../servlets/MIRMailerWithFile?action=contact"
      enctype="multipart/form-data">
      <div class="form-group">
        <label for="inputMessage">
          <xsl:value-of select="mcri18n:translate('project.contact_form.message')" />
        </label>
        <textarea
          id="inputMessage"
          name="message"
          class="form-control input-md"
          rows="3"
          required="required">
        </textarea>
      </div>
      <div class="form-group">
        <label for="inputEmail">
          <xsl:value-of select="mcri18n:translate('project.contact_form.email')" />
        </label>
        <input
          type="email"
          id="inputEmail"
          name="mail"
          class="form-control"
          required="required" />
      </div>
      <div class="form-group">
        <label for="inputName">
          <xsl:value-of select="mcri18n:translate('project.contact_form.name')" />
        </label>
        <input
          type="text"
          id="inputName"
          name="name"
          class="form-control" />
      </div>
      <div class="form-row">
        <div class="col-md">
          <label for="captcha-input">
            <xsl:value-of select="mcri18n:translate('project.contact_form.captcha')" />
          </label>
          <div class="d-flex align-items-center">
            <img
              id="captcha-image"
              src="../../servlets/MIRMailerWithFile?action=captcha"
              alt="captcha"
              class="img-fluid"
            />
            <div class="d-flex flex-column align-items-center">
              <a href="#" id="captcha-refresh">
                <i class="fa fa-refresh"></i>
              </a>
              <a href="#" id="captcha-play">
                <i class="fa-solid fa-volume-high"></i>
              </a>
              <a href="#" id="captcha-stop" class="d-none">
                <i class="fa-solid fa-volume-xmark"></i>
              </a>
            </div>
          </div>
        </div>
      </div>
      <div class="form-row">
        <div class="col-md mb-3">
          <input
            type="text"
            id="captcha-input"
            name="captcha"
            class="form-control"
            required="required"
            autocomplete="off"
            value=""
          />
        </div>
      </div>
      <button id="save" class="btn btn-info" type="submit">
        <xsl:value-of select="mcri18n:translate('project.contact_form.submit')" />
      </button>
    </form>
    <script>
      document.querySelectorAll('input[required], textarea[required]').forEach(el => {
        const label = document.querySelector(`label[for="${el.id}"]`);
        if (label) {
          label.innerHTML += ' *';
        }
      });
    </script>
    <script src="../../js/captcha.js" type="text/javascript"></script>
    <script src="../../js/mailer-with-file.js" type="text/javascript"></script>
  </xsl:template>

</xsl:stylesheet>
