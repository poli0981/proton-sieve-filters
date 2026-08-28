# Work filter -- filter/work.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/work.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Professional and business correspondence.
#
# Folders: Work, Work/Career, Work/Finance, Work/HR, Work/IT, Work/Meetings,
#          Work/Projects, Work/Reminders, Work/Reports, Work/Sales
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 12 of 14. Filters run in the order you install them, and on
# conflicting actions the last one wins -- see README.md for the full order.
#
# Version: 0.2.1

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

if anyof (
    address :domain :matches "from" ["15five.com", "*.15five.com", "activeinboxhq.com",
        "*.activeinboxhq.com", "acuityscheduling.com", "*.acuityscheduling.com",
        "adp.com", "*.adp.com", "airtable.com", "*.airtable.com", "amplitude.com",
        "*.amplitude.com", "angel.co", "*.angel.co", "any.do", "*.any.do", "aol.com",
        "*.aol.com", "apollo.io", "*.apollo.io", "appear.in", "*.appear.in",
        "appointlet.com", "*.appointlet.com", "asana.com", "*.asana.com",
        "atlassian.com", "*.atlassian.com", "aws.amazon.com", "*.aws.amazon.com",
        "azure.com", "*.azure.com", "bamboohr.com", "*.bamboohr.com", "basecamp.com",
        "*.basecamp.com", "bear.app", "*.bear.app", "bigbluebutton.org",
        "*.bigbluebutton.org", "bitbucket.org", "*.bitbucket.org", "bookwhen.com",
        "*.bookwhen.com", "boomeranggmail.com", "*.boomeranggmail.com", "box.com",
        "*.box.com", "breathehr.com", "*.breathehr.com", "calendly.com",
        "*.calendly.com", "canva.com", "*.canva.com", "chartio.com", "*.chartio.com",
        "clickup.com", "*.clickup.com", "clio.com", "*.clio.com", "clockify.me",
        "*.clockify.me", "clockwise.com", "*.clockwise.com", "close.com", "*.close.com",
        "cloudflare.com", "*.cloudflare.com", "coda.io", "*.coda.io", "concur.com",
        "*.concur.com", "confluence.com", "*.confluence.com", "contractbook.com",
        "*.contractbook.com", "copper.com", "*.copper.com", "craft.do", "*.craft.do",
        "datadog.com", "*.datadog.com", "dice.com", "*.dice.com", "digitalocean.com",
        "*.digitalocean.com", "docusign.com", "*.docusign.com", "drift.com",
        "*.drift.com", "drive.google.com", "*.drive.google.com", "dropbox.com",
        "*.dropbox.com", "egghead.io", "*.egghead.io", "evernote.com", "*.evernote.com",
        "expensify.com", "*.expensify.com", "figma.com", "*.figma.com", "framer.com",
        "*.framer.com", "freeagent.com", "*.freeagent.com", "freshbooks.com",
        "*.freshbooks.com", "freshdesk.com", "*.freshdesk.com", "freshworks.com",
        "*.freshworks.com", "frontapp.com", "*.frontapp.com", "getmailbird.com",
        "*.getmailbird.com", "github.com", "*.github.com", "gitlab.com", "*.gitlab.com",
        "gmail.com", "*.gmail.com", "gmx.com", "*.gmx.com", "google-analytics.com",
        "*.google-analytics.com", "google.com", "*.google.com", "gotomeeting.com",
        "*.gotomeeting.com", "grafana.com", "*.grafana.com", "gsuite.google.com",
        "*.gsuite.google.com", "gusto.com", "*.gusto.com", "harvest.com",
        "*.harvest.com", "height.app", "*.height.app", "hellosign.com",
        "*.hellosign.com", "helpwise.io", "*.helpwise.io", "heroku.com", "*.heroku.com",
        "hibob.com", "*.hibob.com", "hired.com", "*.hired.com", "hiverhq.com",
        "*.hiverhq.com", "hotjar.com", "*.hotjar.com", "hubspot.com", "*.hubspot.com",
        "ia.net", "*.ia.net", "icloud.com", "*.icloud.com", "insightly.com",
        "*.insightly.com", "intercom.com", "*.intercom.com", "invisionapp.com",
        "*.invisionapp.com", "ironclad.com", "*.ironclad.com", "jira.com", "*.jira.com",
        "jitsi.org", "*.jitsi.org", "kashoo.com", "*.kashoo.com", "khan.org",
        "*.khan.org", "klaviyo.com", "*.klaviyo.com", "laracasts.com",
        "*.laracasts.com", "lattice.com", "*.lattice.com", "lawgeex.com",
        "*.lawgeex.com", "linear.app", "*.linear.app", "linkedin.com", "*.linkedin.com",
        "logseq.com", "*.logseq.com", "looker.com", "*.looker.com", "lucidchart.com",
        "*.lucidchart.com", "mail.com", "*.mail.com", "meet.google.com",
        "*.meet.google.com", "mega.nz", "*.mega.nz", "metabase.com", "*.metabase.com",
        "microsoft.com", "*.microsoft.com", "miro.com", "*.miro.com", "mixmax.com",
        "*.mixmax.com", "mixpanel.com", "*.mixpanel.com", "monday.com", "*.monday.com",
        "mural.co", "*.mural.co", "mycase.com", "*.mycase.com", "namely.com",
        "*.namely.com", "netlify.com", "*.netlify.com", "netsuite.com",
        "*.netsuite.com", "newrelic.com", "*.newrelic.com", "nextcloud.com",
        "*.nextcloud.com", "nimble.com", "*.nimble.com", "notion.so", "*.notion.so",
        "obsidian.md", "*.obsidian.md", "office365.com", "*.office365.com",
        "omnifocus.com", "*.omnifocus.com", "onedrive.com", "*.onedrive.com",
        "onenote.com", "*.onenote.com", "outlook.com", "*.outlook.com", "outreach.io",
        "*.outreach.io", "owncloud.com", "*.owncloud.com", "pandadoc.com",
        "*.pandadoc.com", "paychex.com", "*.paychex.com", "pcloud.com", "*.pcloud.com",
        "personio.com", "*.personio.com", "pipedrive.com", "*.pipedrive.com",
        "pivotaltracker.com", "*.pivotaltracker.com", "powerbi.microsoft.com",
        "*.powerbi.microsoft.com", "practicepanther.com", "*.practicepanther.com",
        "principle.design", "*.principle.design", "quickbooks.com", "*.quickbooks.com",
        "receipt-bank.com", "*.receipt-bank.com", "rescuetime.com", "*.rescuetime.com",
        "rightinbox.com", "*.rightinbox.com", "rippling.com", "*.rippling.com",
        "roamresearch.com", "*.roamresearch.com", "sage.com", "*.sage.com",
        "salesloft.com", "*.salesloft.com", "sendinblue.com", "*.sendinblue.com",
        "sentry.io", "*.sentry.io", "setmore.com", "*.setmore.com", "shortcut.com",
        "*.shortcut.com", "signrequest.com", "*.signrequest.com", "sketch.com",
        "*.sketch.com", "smartsheet.com", "*.smartsheet.com", "sourceforge.net",
        "*.sourceforge.net", "spotdraft.com", "*.spotdraft.com", "stackoverflow.com",
        "*.stackoverflow.com", "streak.com", "*.streak.com", "superhuman.com",
        "*.superhuman.com", "sync.com", "*.sync.com", "tableau.com", "*.tableau.com",
        "teams.microsoft.com", "*.teams.microsoft.com", "things.app", "*.things.app",
        "thunderbird.net", "*.thunderbird.net", "ticktick.com", "*.ticktick.com",
        "timely.com", "*.timely.com", "todoist.com", "*.todoist.com", "toggl.com",
        "*.toggl.com", "treehouse.com", "*.treehouse.com", "trello.com", "*.trello.com",
        "tresorit.com", "*.tresorit.com", "triplebyte.com", "*.triplebyte.com",
        "tryshift.com", "*.tryshift.com", "ulysses.app", "*.ulysses.app", "vercel.com",
        "*.vercel.com", "wave.com", "*.wave.com", "webex.com", "*.webex.com",
        "wellfound.com", "*.wellfound.com", "whereby.com", "*.whereby.com",
        "whimsical.com", "*.whimsical.com", "workday.com", "*.workday.com",
        "workspace.google.com", "*.workspace.google.com", "wrike.com", "*.wrike.com",
        "xero.com", "*.xero.com", "youcanbook.me", "*.youcanbook.me", "zendesk.com",
        "*.zendesk.com", "zenefits.com", "*.zenefits.com", "zeplin.io", "*.zeplin.io",
        "zoho.com", "*.zoho.com", "zoom.us", "*.zoom.us", "zoomus.com", "*.zoomus.com"],
    header :contains "subject" ["Work", "Office", "Business", "Professional",
        "Corporate", "Company", "Team", "Department", "Meeting", "Project", "Task",
        "Assignment", "Deadline", "Report", "Analysis", "Quarterly", "Annual",
        "Performance", "KPI", "Metrics", "Dashboard", "Training", "Workshop", "Seminar",
        "Conference", "Client", "Customer", "Vendor"],
    header :matches "from" ["*@*corp.com", "*@*inc.com", "*@*ltd.com", "*@*llc.com",
        "*@*group.com", "*@*company.com", "*@*business.com", "*@*enterprise.com",
        "*@*consulting.com", "*@*solutions.com"]
) {
    addflag "\\Seen";
    fileinto "Work";

    if anyof (
        address :domain :matches "from" ["acuityscheduling.com",
            "*.acuityscheduling.com", "calendly.com", "*.calendly.com",
            "meet.google.com", "*.meet.google.com", "teams.microsoft.com",
            "*.teams.microsoft.com", "webex.com", "*.webex.com", "zoom.us", "*.zoom.us"],
        header :contains "subject" ["Meeting Reminder", "Calendar Invite",
            "Schedule Update", "Conference Call", "Zoom Meeting", "Teams Meeting",
            "Webinar Registration", "Appointment Confirmation", "Call Scheduled",
            "Event Reminder", "Meeting Request", "Calendar Update", "Meeting Cancelled",
            "Reschedule Meeting", "Standup Meeting", "All-hands Meeting",
            "Team Meeting", "1:1 Meeting", "Client Meeting"]
    ) {
        fileinto "Work/Meetings";

        if allof (
            header :contains "subject" ["Meeting Today", "Starting in", "Reminder",
                "Now"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["asana.com", "*.asana.com", "clickup.com",
            "*.clickup.com", "github.com", "*.github.com", "gitlab.com", "*.gitlab.com",
            "jira.com", "*.jira.com", "monday.com", "*.monday.com", "trello.com",
            "*.trello.com"],
        header :contains "subject" ["Project Update", "Task Assigned", "Milestone",
            "Deadline Approaching", "Project Report", "Team Progress", "Assignment",
            "Sprint Review", "Epic Update", "Story Points", "Backlog Update",
            "Code Review", "Pull Request", "Merge Request", "Issue Created",
            "Bug Report", "Feature Request", "Release Notes", "Deployment"]
    ) {
        fileinto "Work/Projects";

        if allof (
            header :contains "subject" ["Daily", "Today's Tasks", "Task Reminder",
                "Due Today"],
            size :under 300K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["adp.com", "*.adp.com", "bamboohr.com",
            "*.bamboohr.com", "gusto.com", "*.gusto.com", "workday.com",
            "*.workday.com", "zenefits.com", "*.zenefits.com"],
        header :contains "subject" ["Payroll", "Pay Stub", "Benefits", "PTO Request",
            "Time Off", "Leave Request", "Performance Review", "Employee Survey",
            "Training Required", "Compliance Training", "Policy Update", "HR Notice",
            "Open Enrollment", "401k", "Health Insurance", "Dental Coverage",
            "Employee Handbook", "Code of Conduct", "Onboarding", "Offboarding"]
    ) {
        fileinto "Work/HR";

        if header :contains "subject" ["Payroll", "Pay Stub", "Benefits", "401k",
            "Tax"] {
            expire "day" "90";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["freshworks.com", "*.freshworks.com",
            "hubspot.com", "*.hubspot.com", "pipedrive.com", "*.pipedrive.com",
            "zendesk.com", "*.zendesk.com"],
        header :contains "subject" ["Lead Alert", "Deal Update", "Pipeline Report",
            "Sales Target", "Commission Report", "Customer Update", "CRM Notification",
            "Opportunity Created", "Quote Sent", "Proposal Sent", "Contract Signed",
            "Invoice Sent", "Payment Received", "Customer Feedback", "Support Ticket"]
    ) {
        fileinto "Work/Sales";

        if header :contains "subject" ["Contract", "Invoice", "Payment", "Agreement"] {
            expire "day" "60";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Performance Report", "Analytics Summary",
            "Quarterly Review", "KPI Update", "Metrics Dashboard", "Sales Report",
            "Financial Report", "Business Intelligence", "Data Insights",
            "Audit Results", "Compliance Report", "Weekly Report", "Monthly Report",
            "Annual Report", "Executive Summary"],
        size :over 100K
    ) {
        fileinto "Work/Reports";

        if allof (
            header :contains "subject" ["Quarterly", "Annual", "Executive", "Board",
                "Audit"],
            size :over 500K
        ) {
            expire "day" "180";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["linkedin.com", "*.linkedin.com"],
        header :contains "subject" ["Job Alert", "Career Opportunity",
            "LinkedIn Connection", "Networking Event", "Professional Development",
            "Training Session", "Workshop", "Certification", "Conference Registration",
            "Mentorship", "Resume Update", "Skill Assessment", "Learning Path",
            "Course Enrollment"]
    ) {
        fileinto "Work/Career";

        if allof (
            header :contains "subject" ["Job Alert", "Career Opportunity", "Apply Now"],
            size :under 500K
        ) {
            expire "day" "14";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Daily Reminder", "Follow-up Alert", "Action Item",
            "To-Do Update", "Priority Notification", "Overdue Task", "Quick Check-in",
            "Status Update", "Pending Action", "Time Tracking", "Deadline Today",
            "Daily Standup", "Morning Briefing", "End of Day", "Weekly Goals"],
        size :under 200K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        fileinto "Work/Reminders";

        if header :contains "subject" ["Daily", "Today", "Right Now", "Immediate"] {
            expire "day" "1";
        }

        stop;
    }

    if header :contains "subject" ["IT Notice", "System Update", "Security Alert",
        "Network Maintenance", "Password Expiry", "VPN Access", "Software License",
        "Security Training", "Phishing Test", "Backup Complete",
        "Server Maintenance", "Domain Renewal", "SSL Certificate",
        "Firewall Update", "Antivirus Scan"] {
        fileinto "Work/IT";

        if header :contains "subject" ["Security Alert", "Breach", "Incident",
            "Threat"] {
            expire "day" "30";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["concur.com", "*.concur.com", "expensify.com",
            "*.expensify.com", "freshbooks.com", "*.freshbooks.com", "quickbooks.com",
            "*.quickbooks.com", "xero.com", "*.xero.com"],
        header :contains "subject" ["Invoice", "Receipt", "Expense Report",
            "Budget Update", "Financial Statement", "Account Balance",
            "Payment Confirmation", "Purchase Order", "Vendor Payment", "Reimbursement",
            "Tax Document", "Billing Statement", "Credit Note", "Refund",
            "Subscription Renewal"]
    ) {
        fileinto "Work/Finance";
        expire "day" "365";

        stop;
    }

    if allof (
        header :contains "subject" ["Newsletter", "Product Update",
            "Feature Announcement", "Company News", "Industry News", "Blog Post"],
        size :under 500K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "7";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "14";

    stop;
}

# End of Work filter
