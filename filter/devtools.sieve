# Developer Tools filter -- filter/devtools.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/devtools.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Package registries, CI, hosting and observability.
#
# Folders: Dev
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 5 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

if anyof (
    address :domain :matches "from" ["circleci.com", "*.circleci.com", "crates.io",
        "*.crates.io", "datadoghq.com", "*.datadoghq.com", "docker.com", "*.docker.com",
        "elastic.co", "*.elastic.co", "fastly.com", "*.fastly.com", "fly.io",
        "*.fly.io", "hashicorp.com", "*.hashicorp.com", "jenkins.io", "*.jenkins.io",
        "jetbrains.com", "*.jetbrains.com", "jfrog.com", "*.jfrog.com", "linode.com",
        "*.linode.com", "mongodb.com", "*.mongodb.com", "neon.tech", "*.neon.tech",
        "npmjs.com", "*.npmjs.com", "nuget.org", "*.nuget.org", "packagist.org",
        "*.packagist.org", "pagerduty.com", "*.pagerduty.com", "planetscale.com",
        "*.planetscale.com", "pulumi.com", "*.pulumi.com", "pypi.org", "*.pypi.org",
        "quay.io", "*.quay.io", "railway.app", "*.railway.app", "render.com",
        "*.render.com", "rubygems.org", "*.rubygems.org", "snyk.io", "*.snyk.io",
        "sourcegraph.com", "*.sourcegraph.com", "statuspage.io", "*.statuspage.io",
        "supabase.com", "*.supabase.com", "travis-ci.com", "*.travis-ci.com",
        "vultr.com", "*.vultr.com"],
    header :contains "subject" ["Build Failed", "Build Succeeded", "Deployment",
        "Security Advisory", "Vulnerability Alert", "Dependency Update", "Incident",
        "Downtime", "Usage Report", "Quota Exceeded", "New Release",
        "Package Published"]
) {
    addflag "\\Seen";
    fileinto "Dev";
    expire "day" "30";

    stop;
}

# End of Developer Tools filter
