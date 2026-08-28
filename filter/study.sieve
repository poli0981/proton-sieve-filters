# Study & Education filter -- filter/study.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/study.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Courses, universities, research and learning platforms.
#
# Folders: Study, Study/Algorithms, Study/Art, Study/Biology, Study/Business,
#          Study/Certification, Study/Chemistry, Study/Engineering, Study/General,
#          Study/History, Study/Languages, Study/Mathematics, Study/Medicine,
#          Study/Music, Study/Physics, Study/Programming, Study/Research,
#          Study/TestPrep, Study/Textbooks
#
# Install position 7 of 14. Filters run in the order you install them, and on
# conflicting actions the last one wins -- see README.md for the full order.
#
# Version: 0.2.1

require ["fileinto", "imap4flags", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

if address :domain :matches "from" ["*.ac.jp", "*.ac.uk", "academia.edu",
    "*.academia.edu", "academy.edu", "*.academy.edu", "acm.org", "*.acm.org",
    "adobe.com", "*.adobe.com", "anki.com", "*.anki.com", "artstation.com",
    "*.artstation.com", "autodesk.com", "*.autodesk.com", "babbel.com",
    "*.babbel.com", "blackboard.com", "*.blackboard.com", "brilliant.org",
    "*.brilliant.org", "busuu.com", "*.busuu.com", "cambly.com", "*.cambly.com",
    "cambridge.ac.uk", "*.cambridge.ac.uk", "canvas.com", "*.canvas.com",
    "cengage.com", "*.cengage.com", "cern.ch", "*.cern.ch", "chegg.com",
    "*.chegg.com", "cisco.com", "*.cisco.com", "classdojo.com", "*.classdojo.com",
    "classroom.google.com", "*.classroom.google.com", "codecademy.com",
    "*.codecademy.com", "codepen.io", "*.codepen.io", "codewars.com",
    "*.codewars.com", "college.edu", "*.college.edu", "collegeboard.org",
    "*.collegeboard.org", "comptia.org", "*.comptia.org", "coursehero.com",
    "*.coursehero.com", "coursera.org", "*.coursera.org", "cramfighter.com",
    "*.cramfighter.com", "creativelive.com", "*.creativelive.com", "desmos.com",
    "*.desmos.com", "domestika.org", "*.domestika.org", "drawabox.com",
    "*.drawabox.com", "dribbble.com", "*.dribbble.com", "duolingo.com",
    "*.duolingo.com", "edmodo.com", "*.edmodo.com", "*.edu.au", "*.edu.cn",
    "*.edu.my", "*.edu.sg", "*.edu.tw", "*.edu.vn", "education.gov",
    "*.education.gov", "edx.org", "*.edx.org", "elsevier.com", "*.elsevier.com",
    "epic.com", "epicresearch.org", "*.epicresearch.org", "ets.org", "*.ets.org",
    "exampal.com", "*.exampal.com", "fender.com", "*.fender.com", "flipgrid.com",
    "*.flipgrid.com", "flowkey.com", "*.flowkey.com", "freecodecamp.org",
    "*.freecodecamp.org", "geogebra.org", "*.geogebra.org", "glitch.com",
    "*.glitch.com", "gnomon.edu", "*.gnomon.edu", "hackerrank.com",
    "*.hackerrank.com", "harvard.edu", "*.harvard.edu", "hellotalk.com",
    "*.hellotalk.com", "ibm.com", "*.ibm.com", "ieee.org", "*.ieee.org",
    "institute.edu", "*.institute.edu", "italki.com", "*.italki.com", "jstor.org",
    "*.jstor.org", "kahoot.com", "*.kahoot.com", "kaptest.com", "*.kaptest.com",
    "khanacademy.org", "*.khanacademy.org", "labxchange.org", "*.labxchange.org",
    "leetcode.com", "*.leetcode.com", "lingoda.com", "*.lingoda.com", "lynda.com",
    "*.lynda.com", "magoosh.com", "*.magoosh.com", "manhattanprep.com",
    "*.manhattanprep.com", "masterclass.com", "*.masterclass.com", "mathway.com",
    "*.mathway.com", "mcgraw-hill.com", "*.mcgraw-hill.com", "memrise.com",
    "*.memrise.com", "mendeley.com", "*.mendeley.com", "mit.edu", "*.mit.edu",
    "moodle.org", "*.moodle.org", "musictheory.net", "*.musictheory.net",
    "nasa.gov", "*.nasa.gov", "nature.com", "*.nature.com", "nih.gov", "*.nih.gov",
    "nsf.gov", "*.nsf.gov", "oracle.com", "*.oracle.com", "oxford.ac.uk",
    "*.oxford.ac.uk", "padlet.com", "*.padlet.com", "pearson.com", "*.pearson.com",
    "phet.colorado.edu", "*.phet.colorado.edu", "photomath.com", "*.photomath.com",
    "pluralsight.com", "*.pluralsight.com", "preply.com", "*.preply.com",
    "princetonreview.com", "*.princetonreview.com", "proko.com", "*.proko.com",
    "quizlet.com", "*.quizlet.com", "repl.it", "*.repl.it", "research.org",
    "*.research.org", "researchgate.net", "*.researchgate.net", "rocksmith.com",
    "*.rocksmith.com", "rosettastone.com", "*.rosettastone.com", "salesforce.com",
    "*.salesforce.com", "scholarship.org", "*.scholarship.org", "school.edu",
    "*.school.edu", "schoolism.com", "*.schoolism.com", "schoology.com",
    "*.schoology.com", "science.org", "*.science.org", "seesaw.me", "*.seesaw.me",
    "simply-piano.com", "*.simply-piano.com", "skillshare.com", "*.skillshare.com",
    "sololearn.com", "*.sololearn.com", "speaky.com", "*.speaky.com", "sporcle.com",
    "*.sporcle.com", "springer.com", "*.springer.com", "stanford.edu",
    "*.stanford.edu", "studyblue.com", "*.studyblue.com", "symbolab.com",
    "*.symbolab.com", "tandem.net", "*.tandem.net", "ted.com", "*.ted.com",
    "tenuto.com", "*.tenuto.com", "udacity.com", "*.udacity.com", "udemy.com",
    "*.udemy.com", "university.edu", "*.university.edu", "vmware.com",
    "*.vmware.com", "wiley.com", "*.wiley.com", "wolfram.com", "*.wolfram.com",
    "yousician.com", "*.yousician.com", "zotero.org", "*.zotero.org"] {
    addflag "\\Seen";
    fileinto "Study";

    if anyof (
        address :domain :matches "from" ["codecademy.com", "*.codecademy.com",
            "codewars.com", "*.codewars.com", "freecodecamp.org", "*.freecodecamp.org",
            "hackerrank.com", "*.hackerrank.com", "leetcode.com", "*.leetcode.com"],
        header :contains "subject" ["Coding Tutorial", "Programming Assignment",
            "Learn Python", "Code Review", "Programming Challenge", "Debugging Tips",
            "Software Development", "Coding Bootcamp", "Java Lesson", "C++ Project",
            "JavaScript", "HTML CSS", "Web Development", "Mobile App", "Database",
            "API", "Framework", "Library", "study code", "research programming",
            "assignment code", "leetcode", "hackerrank"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Programming";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["codewars.com", "*.codewars.com",
            "hackerrank.com", "*.hackerrank.com", "leetcode.com", "*.leetcode.com"],
        header :contains "subject" ["Algorithm Problem", "Data Structures",
            "Sorting Algorithm", "Graph Theory", "Algorithm Assignment",
            "Complexity Analysis", "Dynamic Programming", "Algorithm Quiz",
            "Search Algorithm", "Recursion", "Tree Structure", "Hash Table",
            "study algorithm", "research data structures", "assignment recursion",
            "Big O"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Algorithms";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["brilliant.org", "*.brilliant.org",
            "desmos.com", "*.desmos.com", "khanacademy.org", "*.khanacademy.org",
            "mathway.com", "*.mathway.com", "symbolab.com", "*.symbolab.com",
            "wolfram.com", "*.wolfram.com"],
        header :contains "subject" ["Math Problem", "Calculus", "Algebra", "Geometry",
            "Statistics", "Differential Equations", "Linear Algebra", "Math Homework",
            "Probability Theory", "Math Challenge", "Trigonometry", "Number Theory",
            "study math", "research calculus", "assignment algebra", "mathematical"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Mathematics";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["labxchange.org", "*.labxchange.org",
            "phet.colorado.edu", "*.phet.colorado.edu"],
        header :contains "subject" ["Physics Experiment", "Quantum Mechanics",
            "Classical Mechanics", "Thermodynamics", "Electromagnetism", "Physics Lab",
            "Relativity Theory", "Wave Physics", "Particle Physics", "Astrophysics",
            "Optics", "Nuclear Physics", "study physics", "research quantum",
            "assignment mechanics", "physical science"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Physics";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["labxchange.org", "*.labxchange.org"],
        header :contains "subject" ["Biology Lab", "Genetics", "Cell Biology",
            "Evolution", "Ecology", "Microbiology", "Human Anatomy", "Plant Biology",
            "Biotechnology", "DNA Analysis", "Molecular Biology", "Biochemistry",
            "Physiology", "study biology", "research genetics", "assignment ecology",
            "life science"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Biology";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["labxchange.org", "*.labxchange.org"],
        header :contains "subject" ["Chemistry Reaction", "Organic Chemistry",
            "Inorganic Chemistry", "Chemical Bonding", "Periodic Table", "Lab Safety",
            "Biochemistry", "Analytical Chemistry", "Physical Chemistry",
            "Experiment Results", "Stoichiometry", "study chemistry",
            "research organic", "assignment bonding", "chemical"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Chemistry";

        stop;
    }

    if header :contains "subject" ["History Timeline", "Ancient Civilizations",
        "World War", "Historical Figures", "Revolution", "Medieval History",
        "Modern History", "Cultural Heritage", "Archaeology", "Historical Analysis",
        "Political Science", "study history", "research civilizations",
        "assignment revolution", "historical"] {
        addflag "\\Seen";
        fileinto "Study/History";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["babbel.com", "*.babbel.com", "busuu.com",
            "*.busuu.com", "duolingo.com", "*.duolingo.com", "italki.com",
            "*.italki.com", "lingoda.com", "*.lingoda.com", "memrise.com",
            "*.memrise.com", "rosettastone.com", "*.rosettastone.com"],
        header :contains "subject" ["Language Lesson", "Vocabulary", "Grammar",
            "Conversation Practice", "Language Immersion", "Translation",
            "Pronunciation", "Foreign Language", "Idioms", "Language Certification",
            "TOEFL", "IELTS", "Linguistic", "study language", "research vocabulary",
            "assignment grammar"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Languages";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["creativelive.com", "*.creativelive.com",
            "domestika.org", "*.domestika.org", "drawabox.com", "*.drawabox.com",
            "proko.com", "*.proko.com", "schoolism.com", "*.schoolism.com",
            "skillshare.com", "*.skillshare.com"],
        header :contains "subject" ["Art Tutorial", "Design Principles",
            "Drawing Lesson", "Painting Technique", "Digital Art", "Graphic Design",
            "UI UX Design", "Photography", "3D Modeling", "Animation", "Illustration",
            "Creative Process", "study art", "research design", "assignment drawing"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Art";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["fender.com", "*.fender.com", "flowkey.com",
            "*.flowkey.com", "musictheory.net", "*.musictheory.net", "simply-piano.com",
            "*.simply-piano.com", "yousician.com", "*.yousician.com"],
        header :contains "subject" ["Music Theory", "Piano Lesson", "Guitar Tutorial",
            "Music Composition", "Audio Production", "Music History",
            "Instrument Practice", "Music Technology", "Sound Design",
            "Music Performance", "study music", "research composition",
            "assignment theory"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Music";

        stop;
    }

    if header :contains "subject" ["Business Administration", "Economics", "Finance",
        "Marketing", "Management", "Entrepreneurship", "Business Strategy",
        "Accounting", "Investment", "MBA", "Business Case Study", "study business",
        "research economics", "assignment marketing"] {
        addflag "\\Seen";
        fileinto "Study/Business";

        stop;
    }

    if header :contains "subject" ["Engineering Design", "Mechanical Engineering",
        "Electrical Engineering", "Civil Engineering", "Chemical Engineering",
        "Software Engineering", "Engineering Mathematics", "CAD", "Circuit Design",
        "Structural Analysis", "study engineering", "research design",
        "assignment circuit"] {
        addflag "\\Seen";
        fileinto "Study/Engineering";

        stop;
    }

    if header :contains "subject" ["Medical Studies", "Anatomy", "Physiology",
        "Pharmacology", "Clinical Medicine", "Medical Research", "Health Science",
        "Nursing", "Public Health", "Medical Ethics", "Patient Care",
        "study medicine", "research clinical", "assignment anatomy"] {
        addflag "\\Seen";
        fileinto "Study/Medicine";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["collegeboard.org", "*.collegeboard.org",
            "ets.org", "*.ets.org", "kaptest.com", "*.kaptest.com", "magoosh.com",
            "*.magoosh.com", "princetonreview.com", "*.princetonreview.com"],
        header :contains "subject" ["SAT Prep", "GRE Preparation", "GMAT Study",
            "TOEFL Test", "IELTS Preparation", "ACT Practice", "Test Strategy",
            "Exam Preparation", "Practice Test", "Test Score", "Standardized Test",
            "study test", "research exam", "assignment practice"]
    ) {
        addflag "\\Seen";
        fileinto "Study/TestPrep";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["cisco.com", "*.cisco.com",
            "classroom.google.com", "*.classroom.google.com", "comptia.org",
            "*.comptia.org", "salesforce.com", "*.salesforce.com"],
        header :contains "subject" ["Certification Exam", "Professional Certificate",
            "IT Certification", "AWS Certification", "Microsoft Certification",
            "Google Certification", "CompTIA", "Cisco Certification",
            "Project Management", "PMP", "study certification", "research certificate",
            "assignment exam"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Certification";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["academia.edu", "*.academia.edu",
            "elsevier.com", "*.elsevier.com", "jstor.org", "*.jstor.org",
            "mendeley.com", "*.mendeley.com", "nature.com", "*.nature.com",
            "researchgate.net", "*.researchgate.net", "springer.com", "*.springer.com"],
        header :contains "subject" ["Research Paper", "Academic Writing", "Thesis",
            "Dissertation", "Literature Review", "Research Methodology", "Citation",
            "Bibliography", "Peer Review", "Academic Publication", "Journal Article",
            "study research", "research writing", "assignment thesis"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Research";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["cengage.com", "*.cengage.com",
            "mcgraw-hill.com", "*.mcgraw-hill.com", "pearson.com", "*.pearson.com",
            "springer.com", "*.springer.com", "wiley.com", "*.wiley.com"],
        header :contains "subject" ["Textbook", "Reference Book", "Course Book",
            "Study Guide", "Academic Book", "Digital Book", "Ebook", "Required Reading",
            "Course Material", "Study Resources", "study textbook", "research book",
            "assignment reading"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Textbooks";

        stop;
    }

    if header :contains "subject" ["Study", "Learning", "Education", "Academic",
        "Course", "Lesson", "Tutorial", "Lecture", "Assignment", "Homework", "Quiz",
        "Exam", "Grade", "Semester", "Module", "Workshop", "Webinar",
        "study general", "research overview", "assignment general", "educational"] {
        addflag "\\Seen";
        fileinto "Study/General";

        stop;
    }

    stop;
}

# End of Study & Education filter
