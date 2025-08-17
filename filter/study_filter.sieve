# Sieve filter
# Filter_Study.sieve
# Only for user use Proton Mail.
# Version: 0.1.0
# This Sieve script filters messages related to educational and academic platforms, moves them to appropriate Study subfolders.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to education and study
if anyof (
    # Educational institutions
    address :domain :matches "from" ["*university.edu", "*college.edu", "*school.edu", 
    "*institute.edu", "*academy.edu", "*.ac.uk", "*.ac.jp", "*.edu.au",
    "*.edu.sg", "*.edu.my", "*.edu.vn", "*.edu.cn", "*.edu.tw"],

    # Research organizations
    address :domain :matches "from" ["*research.org", "*scholarship.org", "*education.gov",
    "*nsf.gov", "*nih.gov", "*nasa.gov", "*cern.ch", "*mit.edu", "*stanford.edu",
    "*harvard.edu", "*oxford.ac.uk", "*cambridge.ac.uk", "*epicresearch.org", "epic.com"],

    # Online learning platforms
    address :domain :matches "from" ["*coursera.org", "*edx.org", "*khanacademy.org", 
    "*duolingo.com", "*udemy.com", "*skillshare.com", "*masterclass.com",
    "*udacity.com", "*pluralsight.com", "*lynda.com", "*linkedin.com"],

    # Language learning platforms
    address :domain :matches "from" ["*babbel.com", "*rosettastone.com", "*busuu.com",
    "*memrise.com", "*lingoda.com", "*italki.com", "*preply.com", "*cambly.com",
    "*hellotalk.com", "*tandem.net", "*speaky.com"],

    # Academic tools and platforms
    address :domain :matches "from" ["*quizlet.com", "*classroom.google.com", "*canvas.com",
    "*blackboard.com", "*moodle.org", "*schoology.com", "*edmodo.com", "*seesaw.me",
    "*classdojo.com", "*kahoot.com", "*padlet.com", "*flipgrid.com"],

    # Programming and tech education
    address :domain :matches "from" ["*codecademy.com", "*freecodecamp.org", "*codepen.io",
    "*github.com", "*stackoverflow.com", "*hackerrank.com", "*leetcode.com",
    "*codewars.com", "*sololearn.com", "*repl.it", "*glitch.com"],

    # Academic publishers and journals
    address :domain :matches "from" ["*springer.com", "*elsevier.com", "*wiley.com",
    "*nature.com", "*science.org", "*ieee.org", "*acm.org", "*jstor.org",
    "*academia.edu", "*researchgate.net", "*mendeley.com", "*zotero.org"],

    # Educational apps and tools
    address :domain :matches "from" ["*photomath.com", "*wolfram.com", "*symbolab.com",
    "*geogebra.org", "*desmos.com", "*labxchange.org", "*phet.colorado.edu",
    "*khanacademy.org", "*ted.com", "*coursehero.com"],

    # Professional certification platforms
    address :domain :matches "from" ["*comptia.org", "*cisco.com", "*microsoft.com",
    "*amazon.com", "*google.com", "*ibm.com", "*oracle.com", "*salesforce.com",
    "*vmware.com", "*adobe.com", "*autodesk.com"],

    # Test prep platforms
    address :domain :matches "from" ["*ets.org", "*collegeboard.org", "*kaptest.com",
    "*princetonreview.com", "*manhattanprep.com", "*magoosh.com", "*exampal.com"],

    # Art and creative education
    address :domain :matches "from" ["*domestika.org", "*creativelive.com", "*schoolism.com",
    "*gnomon.edu", "*artstation.com", "*behance.net", "*dribbble.com",
    "*proko.com", "*drawabox.com"],

    # Music education
    address :domain :matches "from" ["*fender.com", "*yousician.com", "*flowkey.com",
    "*simply-piano.com", "*rocksmith.com", "*musictheory.net", "*tenuto.com"],

    # Science and math platforms
    address :domain :matches "from" ["*brilliant.org", "*mathway.com", "*chegg.com",
    "*studyblue.com", "*cramfighter.com", "*anki.com", "*sporcle.com"]
) {
    # Programming and Computer Science
    if anyof (
        header :contains "subject" ["Coding Tutorial", "Programming Assignment", "Learn Python", 
        "Code Review", "Programming Challenge", "Debugging Tips", "Software Development", 
        "Coding Bootcamp", "Java Lesson", "C++ Project", "JavaScript", "HTML CSS",
        "Web Development", "Mobile App", "Database", "API", "Framework", "Library",
        "study code", "research programming", "assignment code", "leetcode", "hackerrank"],
        address :domain :matches "from" ["*codecademy.com", "*freecodecamp.org", "*github.com",
        "*stackoverflow.com", "*hackerrank.com", "*leetcode.com", "*codewars.com"]
    ) {
        fileinto "Study/Programming";
        addflag "\\Seen";
        stop;
    }

    # Data Structures and Algorithms
    if anyof (
        header :contains "subject" ["Algorithm Problem", "Data Structures", "Sorting Algorithm", 
        "Graph Theory", "Algorithm Assignment", "Complexity Analysis", "Dynamic Programming", 
        "Algorithm Quiz", "Search Algorithm", "Recursion", "Tree Structure", "Hash Table",
        "study algorithm", "research data structures", "assignment recursion", "Big O"],
        address :domain :matches "from" ["*leetcode.com", "*hackerrank.com", "*codewars.com"]
    ) {
        fileinto "Study/Algorithms";
        addflag "\\Seen";
        stop;
    }

    # Mathematics
    if anyof (
        header :contains "subject" ["Math Problem", "Calculus", "Algebra", "Geometry", 
        "Statistics", "Differential Equations", "Linear Algebra", "Math Homework", 
        "Probability Theory", "Math Challenge", "Trigonometry", "Number Theory",
        "study math", "research calculus", "assignment algebra", "mathematical"],
        address :domain :matches "from" ["*wolfram.com", "*symbolab.com", "*mathway.com",
        "*desmos.com", "*brilliant.org", "*khanacademy.org"]
    ) {
        fileinto "Study/Mathematics";
        addflag "\\Seen";
        stop;
    }

    # Physics
    if anyof (
        header :contains "subject" ["Physics Experiment", "Quantum Mechanics", "Classical Mechanics", 
        "Thermodynamics", "Electromagnetism", "Physics Lab", "Relativity Theory", 
        "Wave Physics", "Particle Physics", "Astrophysics", "Optics", "Nuclear Physics",
        "study physics", "research quantum", "assignment mechanics", "physical science"],
        address :domain :matches "from" ["*phet.colorado.edu", "*labxchange.org"]
    ) {
        fileinto "Study/Physics";
        addflag "\\Seen";
        stop;
    }

    # Biology and Life Sciences
    if anyof (
        header :contains "subject" ["Biology Lab", "Genetics", "Cell Biology", "Evolution", 
        "Ecology", "Microbiology", "Human Anatomy", "Plant Biology", "Biotechnology", 
        "DNA Analysis", "Molecular Biology", "Biochemistry", "Physiology",
        "study biology", "research genetics", "assignment ecology", "life science"],
        address :domain :matches "from" ["*labxchange.org"]
    ) {
        fileinto "Study/Biology";
        addflag "\\Seen";
        stop;
    }

    # Chemistry
    if anyof (
        header :contains "subject" ["Chemistry Reaction", "Organic Chemistry", "Inorganic Chemistry", 
        "Chemical Bonding", "Periodic Table", "Lab Safety", "Biochemistry", 
        "Analytical Chemistry", "Physical Chemistry", "Experiment Results", "Stoichiometry",
        "study chemistry", "research organic", "assignment bonding", "chemical"],
        address :domain :matches "from" ["*labxchange.org"]
    ) {
        fileinto "Study/Chemistry";
        addflag "\\Seen";
        stop;
    }

    # History and Social Studies
    if anyof (
        header :contains "subject" ["History Timeline", "Ancient Civilizations", "World War", 
        "Historical Figures", "Revolution", "Medieval History", "Modern History", 
        "Cultural Heritage", "Archaeology", "Historical Analysis", "Political Science",
        "study history", "research civilizations", "assignment revolution", "historical"]
    ) {
        fileinto "Study/History";
        addflag "\\Seen";
        stop;
    }

    # Languages and Linguistics
    if anyof (
        header :contains "subject" ["Language Lesson", "Vocabulary", "Grammar", "Conversation Practice", 
        "Language Immersion", "Translation", "Pronunciation", "Foreign Language", 
        "Idioms", "Language Certification", "TOEFL", "IELTS", "Linguistic",
        "study language", "research vocabulary", "assignment grammar"],
        address :domain :matches "from" ["*duolingo.com", "*babbel.com", "*rosettastone.com",
        "*busuu.com", "*memrise.com", "*lingoda.com", "*italki.com"]
    ) {
        fileinto "Study/Languages";
        addflag "\\Seen";
        stop;
    }

    # Art and Design
    if anyof (
        header :contains "subject" ["Art Tutorial", "Design Principles", "Drawing Lesson", 
        "Painting Technique", "Digital Art", "Graphic Design", "UI UX Design", 
        "Photography", "3D Modeling", "Animation", "Illustration", "Creative Process",
        "study art", "research design", "assignment drawing"],
        address :domain :matches "from" ["*domestika.org", "*creativelive.com", "*schoolism.com",
        "*proko.com", "*drawabox.com", "*skillshare.com"]
    ) {
        fileinto "Study/Art";
        addflag "\\Seen";
        stop;
    }

    # Music and Audio
    if anyof (
        header :contains "subject" ["Music Theory", "Piano Lesson", "Guitar Tutorial", 
        "Music Composition", "Audio Production", "Music History", "Instrument Practice", 
        "Music Technology", "Sound Design", "Music Performance",
        "study music", "research composition", "assignment theory"],
        address :domain :matches "from" ["*fender.com", "*yousician.com", "*flowkey.com",
        "*simply-piano.com", "*musictheory.net"]
    ) {
        fileinto "Study/Music";
        addflag "\\Seen";
        stop;
    }

    # Business and Economics
    if anyof (
        header :contains "subject" ["Business Administration", "Economics", "Finance", 
        "Marketing", "Management", "Entrepreneurship", "Business Strategy", 
        "Accounting", "Investment", "MBA", "Business Case Study",
        "study business", "research economics", "assignment marketing"]
    ) {
        fileinto "Study/Business";
        addflag "\\Seen";
        stop;
    }

    # Engineering
    if anyof (
        header :contains "subject" ["Engineering Design", "Mechanical Engineering", "Electrical Engineering", 
        "Civil Engineering", "Chemical Engineering", "Software Engineering", 
        "Engineering Mathematics", "CAD", "Circuit Design", "Structural Analysis",
        "study engineering", "research design", "assignment circuit"]
    ) {
        fileinto "Study/Engineering";
        addflag "\\Seen";
        stop;
    }

    # Medicine and Health
    if anyof (
        header :contains "subject" ["Medical Studies", "Anatomy", "Physiology", "Pharmacology", 
        "Clinical Medicine", "Medical Research", "Health Science", "Nursing", 
        "Public Health", "Medical Ethics", "Patient Care",
        "study medicine", "research clinical", "assignment anatomy"]
    ) {
        fileinto "Study/Medicine";
        addflag "\\Seen";
        stop;
    }

    # Test Preparation
    if anyof (
        header :contains "subject" ["SAT Prep", "GRE Preparation", "GMAT Study", "TOEFL Test", 
        "IELTS Preparation", "ACT Practice", "Test Strategy", "Exam Preparation", 
        "Practice Test", "Test Score", "Standardized Test",
        "study test", "research exam", "assignment practice"],
        address :domain :matches "from" ["*ets.org", "*collegeboard.org", "*kaptest.com",
        "*princetonreview.com", "*magoosh.com"]
    ) {
        fileinto "Study/TestPrep";
        addflag "\\Seen";
        stop;
    }

    # Professional Certification
    if anyof (
        header :contains "subject" ["Certification Exam", "Professional Certificate", "IT Certification", 
        "AWS Certification", "Microsoft Certification", "Google Certification", 
        "CompTIA", "Cisco Certification", "Project Management", "PMP",
        "study certification", "research certificate", "assignment exam"],
        address :domain :matches "from" ["*comptia.org", "*cisco.com", "*microsoft.com",
        "*amazon.com", "*google.com", "*salesforce.com"]
    ) {
        fileinto "Study/Certification";
        addflag "\\Seen";
        stop;
    }

    # Research and Academic Writing
    if anyof (
        header :contains "subject" ["Research Paper", "Academic Writing", "Thesis", "Dissertation", 
        "Literature Review", "Research Methodology", "Citation", "Bibliography", 
        "Peer Review", "Academic Publication", "Journal Article",
        "study research", "research writing", "assignment thesis"],
        address :domain :matches "from" ["*springer.com", "*elsevier.com", "*nature.com",
        "*jstor.org", "*academia.edu", "*researchgate.net", "*mendeley.com"]
    ) {
        fileinto "Study/Research";
        addflag "\\Seen";
        stop;
    }

    # Textbooks and References
    if anyof (
        header :contains "subject" ["Textbook", "Reference Book", "Course Book", "Study Guide", 
        "Academic Book", "Digital Book", "Ebook", "Required Reading", 
        "Course Material", "Study Resources",
        "study textbook", "research book", "assignment reading"],
        address :domain :matches "from" ["*pearson.com", "*mcgraw-hill.com", "*cengage.com",
        "*wiley.com", "*springer.com"]
    ) {
        fileinto "Study/Textbooks";
        addflag "\\Seen";
        stop;
    }

    # General Academic (catch-all for unspecified study content)
    if anyof (
        header :contains "subject" ["Study", "Learning", "Education", "Academic", "Course", 
        "Lesson", "Tutorial", "Lecture", "Assignment", "Homework", "Quiz", 
        "Exam", "Grade", "Semester", "Module", "Workshop", "Webinar",
        "study general", "research overview", "assignment general", "educational"]
    ) {
        fileinto "Study/General";
        addflag "\\Seen";
        stop;
    }

    # Default: if no specific category matches, file to Study folder
    fileinto "Study";
    addflag "\\Seen";

    stop;
}

# End of Study Filter