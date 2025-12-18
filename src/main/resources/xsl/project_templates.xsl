<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="contact-form">
    <form
      role="form"
      method="post"
      class="form-horizontal needs-validation"
      action="../../servlets/MIRMailerWithFile?action=contact"
      enctype="multipart/form-data">
      <div class="form-group">
        <label for="inputMessage">
          <xsl:value-of select="document('i18n:project.contact_form.message')/i18n/text()" />
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
          <xsl:value-of select="document('i18n:project.contact_form.email')/i18n/text()" />
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
          <xsl:value-of select="document('i18n:project.contact_form.name')/i18n/text()" />
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
            <xsl:value-of select="document('i18n:project.contact_form.captcha')/i18n/text()" />
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
        <xsl:value-of select="document('i18n:project.contact_form.submit')/i18n/text()" />
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
