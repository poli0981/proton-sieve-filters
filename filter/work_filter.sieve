# Sieve filter
# Filter_Work.sieve
# Only for user use Proton Mail.
# Version: 0.2.0
# This Sieve script filters messages related to work/professional platforms, moves them to "Work" folder or subfolders.

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to work/professional
if anyof (
    address :domain :matches "from" [
    # Major Email & Communication Platforms
    "*microsoft.com", "*outlook.com", "*office365.com", "*teams.microsoft.com",
    "*google.com", "*gmail.com", "*workspace.google.com", "*gsuite.google.com",
    "*zoho.com", "*proton.me", "*apple.com", "*icloud.com",
    "*yahoo.com", "*aol.com", "*mail.com", "*gmx.com",
    
    # Professional Email Clients & Tools
    "*getmailbird.com", "*thunderbird.net", "*superhuman.com", "*frontapp.com",
    "*tryshift.com", "*helpwise.io", "*hiverhq.com", "*activeinboxhq.com",
    "*boomeranggmail.com", "*rightinbox.com", "*mixmax.com", "*streak.com",
    
    # Communication & Collaboration
    "*slack.com", "*discord.com", "*zoom.us", "*zoomus.com", "*webex.com",
    "*gotomeeting.com", "*skype.com", "*teams.microsoft.com", "*meet.google.com",
    "*whereby.com", "*bigbluebutton.org", "*jitsi.org", "*appear.in",
    
    # Project Management & Productivity
    "*asana.com", "*trello.com", "*notion.so", "*monday.com", "*clickup.com",
    "*atlassian.com", "*jira.com", "*confluence.com", "*basecamp.com",
    "*wrike.com", "*smartsheet.com", "*airtable.com", "*coda.io",
    "*linear.app", "*height.app", "*shortcut.com", "*pivotaltracker.com",
    
    # Task Management & Notes
    "*todoist.com", "*any.do", "*ticktick.com", "*things.app", "*omnifocus.com",
    "*evernote.com", "*onenote.com", "*bear.app", "*obsidian.md", "*roamresearch.com",
    "*logseq.com", "*craft.do", "*ulysses.app", "*ia.net",
    
    # Cloud Storage & File Sharing
    "*dropbox.com", "*box.com", "*onedrive.com", "*drive.google.com",
    "*icloud.com", "*mega.nz", "*pcloud.com", "*sync.com",
    "*tresorit.com", "*nextcloud.com", "*owncloud.com",
    
    # HR & Employee Management
    "*workday.com", "*adp.com", "*paychex.com", "*gusto.com", "*bamboohr.com",
    "*zenefits.com", "*namely.com", "*rippling.com", "*personio.com",
    "*breathehr.com", "*hibob.com", "*15five.com", "*lattice.com",
    
    # CRM & Sales Tools
    "*salesforce.com", "*hubspot.com", "*pipedrive.com", "*freshworks.com",
    "*zoho.com", "*insightly.com", "*nimble.com", "*copper.com",
    "*close.com", "*outreach.io", "*salesloft.com", "*apollo.io",
    
    # Marketing & Analytics
    "*mailchimp.com", "*constantcontact.com", "*sendinblue.com", "*klaviyo.com",
    "*intercom.com", "*drift.com", "*zendesk.com", "*freshdesk.com",
    "*google-analytics.com", "*mixpanel.com", "*amplitude.com", "*hotjar.com",
    
    # Financial & Accounting
    "*quickbooks.com", "*xero.com", "*freshbooks.com", "*wave.com",
    "*sage.com", "*netsuite.com", "*concur.com", "*expensify.com",
    "*receipt-bank.com", "*freeagent.com", "*kashoo.com",
    
    # Professional Services & Legal
    "*docusign.com", "*hellosign.com", "*pandadoc.com", "*signrequest.com",
    "*lawgeex.com", "*contractbook.com", "*ironclad.com", "*spotdraft.com",
    "*clio.com", "*mycase.com", "*practicepanther.com",
    
    # Job Platforms & Career
    "*linkedin.com", "*indeed.com", "*glassdoor.com", "*monster.com",
    "*careerbuilder.com", "*ziprecruiter.com", "*dice.com", "*stackoverflow.com",
    "*angel.co", "*wellfound.com", "*hired.com", "*triplebyte.com",
    
    # Learning & Development
    "*udemy.com", "*coursera.org", "*linkedin.com", "*pluralsight.com",
    "*skillshare.com", "*masterclass.com", "*edx.org", "*khan.org",
    "*codecademy.com", "*treehouse.com", "*laracasts.com", "*egghead.io",
    
    # Design & Creative Tools
    "*figma.com", "*sketch.com", "*adobe.com", "*canva.com",
    "*invisionapp.com", "*zeplin.io", "*principle.design", "*framer.com",
    "*miro.com", "*mural.co", "*whimsical.com", "*lucidchart.com",
    
    # Development & IT Tools
    "*github.com", "*gitlab.com", "*bitbucket.org", "*sourceforge.net",
    "*heroku.com", "*digitalocean.com", "*aws.amazon.com", "*azure.com",
    "*vercel.com", "*netlify.com", "*cloudflare.com", "*sentry.io",
    
    # Time Tracking & Scheduling
    "*toggl.com", "*harvest.com", "*clockify.me", "*rescuetime.com",
    "*timely.com", "*clockwise.com", "*calendly.com", "*acuityscheduling.com",
    "*bookwhen.com", "*setmore.com", "*appointlet.com", "*youcanbook.me",
    
    # Business Intelligence & Data
    "*tableau.com", "*powerbi.microsoft.com", "*looker.com", "*chartio.com",
    "*metabase.com", "*grafana.com", "*datadog.com", "*newrelic.com"
    ],
    
    # Work-related keywords in subject or from field
    header :contains "subject" ["Work", "Office", "Business", "Professional", 
    "Corporate", "Company", "Team", "Department", "Meeting", "Project",
    "Task", "Assignment", "Deadline", "Report", "Analysis", "Quarterly",
    "Annual", "Performance", "KPI", "Metrics", "Dashboard", "Training",
    "Workshop", "Seminar", "Conference", "Client", "Customer", "Vendor"],
    
    # Professional email domains (common business patterns)
    header :matches "from" ["*@*corp.com", "*@*inc.com", "*@*ltd.com", 
    "*@*llc.com", "*@*group.com", "*@*company.com", "*@*business.com",
    "*@*enterprise.com", "*@*consulting.com", "*@*solutions.com"]
) {
    # Mark email as read first
    addflag "\\Seen";
    
    # Move to "Work" folder by default
    fileinto "Work";

    # ========================================================================
    # MEETINGS & CALENDAR
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Meeting Reminder", "Calendar Invite", "Schedule Update", 
        "Conference Call", "Zoom Meeting", "Teams Meeting", "Webinar Registration", 
        "Appointment Confirmation", "Call Scheduled", "Event Reminder", "Meeting Request",
        "Calendar Update", "Meeting Cancelled", "Reschedule Meeting", "Standup Meeting",
        "All-hands Meeting", "Team Meeting", "1:1 Meeting", "Client Meeting"],
        address :domain :matches "from" ["*zoom.us", "*teams.microsoft.com", "*meet.google.com",
        "*calendly.com", "*acuityscheduling.com", "*webex.com"]
    ) {
        fileinto "Work/Meetings";
        
        # Meeting invites/reminders (expire 7 days after meeting)
        if allof (
            header :contains "subject" ["Meeting Today", "Starting in", "Reminder", "Now"],
            size :under 500K
        ) {
            expire "day" "3";
        }
        
        stop;
    }

    # ========================================================================
    # PROJECTS & TASKS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Project Update", "Task Assigned", "Milestone", 
        "Deadline Approaching", "Project Report", "Team Progress", "Assignment", 
        "Sprint Review", "Epic Update", "Story Points", "Backlog Update",
        "Code Review", "Pull Request", "Merge Request", "Issue Created",
        "Bug Report", "Feature Request", "Release Notes", "Deployment"],
        address :domain :matches "from" ["*asana.com", "*trello.com", "*jira.com", 
        "*github.com", "*gitlab.com", "*clickup.com", "*monday.com"]
    ) {
        fileinto "Work/Projects";
        
        # Daily task updates (expire 7 days)
        if allof (
            header :contains "subject" ["Daily", "Today's Tasks", "Task Reminder", "Due Today"],
            size :under 300K
        ) {
            expire "day" "7";
        }
        
        stop;
    }

    # ========================================================================
    # HR & EMPLOYEE MANAGEMENT  
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Payroll", "Pay Stub", "Benefits", "PTO Request", 
        "Time Off", "Leave Request", "Performance Review", "Employee Survey", 
        "Training Required", "Compliance Training", "Policy Update", "HR Notice",
        "Open Enrollment", "401k", "Health Insurance", "Dental Coverage",
        "Employee Handbook", "Code of Conduct", "Onboarding", "Offboarding"],
        address :domain :matches "from" ["*workday.com", "*adp.com", "*bamboohr.com", 
        "*gusto.com", "*zenefits.com"]
    ) {
        fileinto "Work/HR";
        
        # Keep financial records longer (90 days)
        if header :contains "subject" ["Payroll", "Pay Stub", "Benefits", "401k", "Tax"] {
            expire "day" "90";
        }
        
        stop;
    }

    # ========================================================================
    # SALES & CRM
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Lead Alert", "Deal Update", "Pipeline Report", 
        "Sales Target", "Commission Report", "Customer Update", "CRM Notification",
        "Opportunity Created", "Quote Sent", "Proposal Sent", "Contract Signed",
        "Invoice Sent", "Payment Received", "Customer Feedback", "Support Ticket"],
        address :domain :matches "from" ["*salesforce.com", "*hubspot.com", "*pipedrive.com",
        "*freshworks.com", "*zendesk.com"]
    ) {
        fileinto "Work/Sales";
        
        # Customer records (keep longer - 60 days)
        if header :contains "subject" ["Contract", "Invoice", "Payment", "Agreement"] {
            expire "day" "60";
        }
        
        stop;
    }

    # ========================================================================
    # REPORTS & ANALYTICS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Performance Report", "Analytics Summary", "Quarterly Review", 
        "KPI Update", "Metrics Dashboard", "Sales Report", "Financial Report", 
        "Business Intelligence", "Data Insights", "Audit Results", "Compliance Report",
        "Weekly Report", "Monthly Report", "Annual Report", "Executive Summary"],
        size :over 100K  # Reports are usually larger files
    ) {
        fileinto "Work/Reports";
        
        # Important reports (keep longer - 180 days)
        if anyof (
            header :contains "subject" ["Quarterly", "Annual", "Executive", "Board", "Audit"],
            size :over 500K
        ) {
            expire "day" "180";
        }
        
        stop;
    }

    # ========================================================================
    # CAREER & PROFESSIONAL DEVELOPMENT
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Job Alert", "Career Opportunity", "LinkedIn Connection", 
        "Networking Event", "Professional Development", "Training Session", 
        "Workshop", "Certification", "Conference Registration", "Mentorship",
        "Resume Update", "Skill Assessment", "Learning Path", "Course Enrollment"],
        address :domain :matches "from" ["*linkedin.com", "*indeed.com", "*coursera.org",
        "*udemy.com", "*pluralsight.com"]
    ) {
        fileinto "Work/Career";
        
        # Career opportunities (expire 14 days)
        if allof (
            header :contains "subject" ["Job Alert", "Career Opportunity", "Apply Now"],
            size :under 500K
        ) {
            expire "day" "14";
        }
        
        stop;
    }

    # ========================================================================
    # DAILY REMINDERS & NOTIFICATIONS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Daily Reminder", "Follow-up Alert", "Action Item", 
        "To-Do Update", "Priority Notification", "Overdue Task", "Quick Check-in", 
        "Status Update", "Pending Action", "Time Tracking", "Deadline Today",
        "Daily Standup", "Morning Briefing", "End of Day", "Weekly Goals"],
        size :under 200K,  # Reminders are typically small
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        fileinto "Work/Reminders";
        
        # Daily notifications (expire 1 day)
        if header :contains "subject" ["Daily", "Today", "Right Now", "Immediate"] {
            expire "day" "1";
        }
        
        stop;
    }

    # ========================================================================
    # SECURITY & IT
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["IT Notice", "System Update", "Security Alert", 
        "Network Maintenance", "Password Expiry", "VPN Access", "Software License",
        "Security Training", "Phishing Test", "Backup Complete", "Server Maintenance",
        "Domain Renewal", "SSL Certificate", "Firewall Update", "Antivirus Scan"]
    ) {
        fileinto "Work/IT";
        
        # Security alerts (keep longer - 30 days)
        if header :contains "subject" ["Security Alert", "Breach", "Incident", "Threat"] {
            expire "day" "30";
        }
        
        stop;
    }

    # ========================================================================
    # FINANCIAL & ACCOUNTING
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Invoice", "Receipt", "Expense Report", "Budget Update", 
        "Financial Statement", "Account Balance", "Payment Confirmation", 
        "Purchase Order", "Vendor Payment", "Reimbursement", "Tax Document",
        "Billing Statement", "Credit Note", "Refund", "Subscription Renewal"],
        address :domain :matches "from" ["*quickbooks.com", "*xero.com", "*expensify.com",
        "*concur.com", "*freshbooks.com"]
    ) {
        fileinto "Work/Finance";
        
        # Financial records (keep 1 year)
        expire "day" "365";
        
        stop;
    }

    # ========================================================================
    # DEFAULT WORK EXPIRATION RULES
    # ========================================================================

    # Newsletter & marketing (expire 7 days)
    if allof (
        header :contains "subject" ["Newsletter", "Product Update", "Feature Announcement",
        "Company News", "Industry News", "Blog Post"],
        size :under 500K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "7";
        stop;
    }

    # Default expiration for other work content (14 days)
    expire "day" "14";
    
    stop;
}

# End of Sieve script for work filter