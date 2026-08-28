# Government & Tax filter -- filter/government.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/government.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Tax authorities, government agencies and public services.
#
# Folders: Government
#
# Install position 18 of 22. Filters run in the order you install them,
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
    address :domain :matches "from" ["ato.gov.au", "*.ato.gov.au", "canada.ca",
        "*.canada.ca", "cra-arc.gc.ca", "*.cra-arc.gc.ca", "dol.gov", "*.dol.gov",
        "freetaxusa.com", "*.freetaxusa.com", "ftc.gov", "*.ftc.gov", "healthcare.gov",
        "*.healthcare.gov", "hrblock.com", "*.hrblock.com", "ird.govt.nz",
        "*.ird.govt.nz", "irs.gov", "*.irs.gov", "medicare.gov", "*.medicare.gov",
        "sec.gov", "*.sec.gov", "servicesaustralia.gov.au",
        "*.servicesaustralia.gov.au", "ssa.gov", "*.ssa.gov", "studentaid.gov",
        "*.studentaid.gov", "taxact.com", "*.taxact.com", "taxslayer.com",
        "*.taxslayer.com", "treasury.gov", "*.treasury.gov", "turbotax.com",
        "*.turbotax.com", "usa.gov", "*.usa.gov", "uscis.gov", "*.uscis.gov", "va.gov",
        "*.va.gov"],
    header :contains "subject" ["Tax Return", "Tax Refund", "Notice of Assessment",
        "Benefit Statement", "Government Notice", "Public Service", "Jury Summons",
        "Voter Registration", "Passport Application", "Visa Application",
        "Social Security"]
) {
    addflag "\\Seen";
    fileinto "Government";

    stop;
}

# End of Government & Tax filter
