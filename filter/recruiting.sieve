# Recruiting & Applications filter -- filter/recruiting.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/recruiting.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Applicant tracking systems and recruiter correspondence.
#
# Folders: Recruiting
#
# Install position 11 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

if anyof (
    address :domain :matches "from" ["applytojob.com", "*.applytojob.com",
        "ashbyhq.com", "*.ashbyhq.com", "breezy.hr", "*.breezy.hr", "greenhouse.io",
        "*.greenhouse.io", "icims.com", "*.icims.com", "jazzhr.com", "*.jazzhr.com",
        "jobvite.com", "*.jobvite.com", "lever.co", "*.lever.co", "myworkdayjobs.com",
        "*.myworkdayjobs.com", "otta.com", "*.otta.com", "recruitee.com",
        "*.recruitee.com", "smartrecruiters.com", "*.smartrecruiters.com",
        "successfactors.com", "*.successfactors.com", "taleo.net", "*.taleo.net",
        "teamtailor.com", "*.teamtailor.com", "workable.com", "*.workable.com"],
    header :contains "subject" ["Application Received", "Application Update",
        "Interview Invitation", "Interview Scheduled", "Offer Letter",
        "Candidate Assessment", "Take-home Assignment", "Reference Request",
        "Application Status", "Thank You for Applying", "Next Steps"]
) {
    addflag "\\Seen";
    fileinto "Recruiting";

    stop;
}

# End of Recruiting & Applications filter
