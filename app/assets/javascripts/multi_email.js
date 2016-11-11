

function multi_email(subject, email_list) {
    var uniq_email_list = email_list.filter(function(itm, i) {
        return email_list.indexOf(itm)== i; 
    });
    uniq_email_list.join(',');
    window.open("mailto:" + uniq_email_list + "?subject=" + "Force Request System: Regarding course " + subject);
}