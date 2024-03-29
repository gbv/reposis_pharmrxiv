
$(document).ready(function() {

  // spam protection for mails
  $('span.madress').each(function(i) {
      var text = $(this).text();
      var address = text.replace(" [at] ", "@");
      $(this).after('<a href="mailto:'+address+'">'+ address +'</a>')
      $(this).remove();
  });

  $.cookieBar({
    fixed: true,
    message: 'Auf den Seiten von Pharmrxiv werden zur Erhöhung des Bedienungskomforts Cookies verwendet. Mit der Nutzung dieser Seiten erklären Sie, dass Sie die rechtlichen Hinweise gelesen haben und akzeptieren.',
    acceptText: 'Akzeptieren',
    policyButton: true,
    policyText: 'Hinweise zum Datenschutz',
    policyURL: 'https://www.tu-braunschweig.de/datenschutzerklaerung',
    expireDays: 1,
    zindex: '356',
    domain: 'pharmrxiv.de',
    referrer: 'pharmrxiv.de'
  });

  // activate empty search on start page
  $("#project-searchMainPage").submit(function (evt) {
    $(this).find(":input").filter(function () {
          return !this.value;
      }).attr("disabled", true);
    return true;
  });

  // replace placeholder USERNAME with username
  var userID = $("#currentUser strong").html();
  var localHref = 'http://localhost:18301/pharmrxiv/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:' + userID + '&fq=objectType:mods';
  $("a[href='http://localhost:18301/pharmrxiv/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:USERNAME']").attr('href', localHref);
  var testHref = 'https://reposis-test.gbv.de/pharmrxiv/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:' + userID + '&fq=objectType:mods';
  $("a[href='https://reposis-test.gbv.de/pharmrxiv/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:USERNAME']").attr('href', testHref);
  var prodHref = 'https://pharmrxiv.de/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:' + userID + '&fq=objectType:mods';
  $("a[href='https://pharmrxiv.de/servlets/solr/select?q=state%3Asubmitted%20AND%20createdby:USERNAME']").attr('href', prodHref);

});

$( document ).ajaxComplete(function() {
  // remove series and journal as option from publish/index.xml
  $("select#genre option[value='series']").remove();
  $("select#genre option[value='journal']").remove();
});
