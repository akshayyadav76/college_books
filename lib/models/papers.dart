

class Paper {
  String paparName;
  String year;
  String url;
  int semester;


  Paper({this.paparName, this.year, this.url,this.semester});
}

class AllPapers{
  List<List<Paper>> papers = [
   [
 Paper(paparName: "Not Avaliable yet!",
 year: "")
   ],
    [
 Paper(paparName: "Not Avaliable yet!",
 year: "")
   ],
    [
 Paper(paparName: "Not Avaliable yet!",
 year: "")
   ],
   // sem4 papers
    [
      Paper(
        paparName: "Artificial Intelligence & Applications",
        year: " dec 2019",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-401-aftificial-intelligence-and-applications-nov-2019.pdf'
      ),
       Paper(
        paparName: "Information Storage & Management",
        year: "dec 2019c",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-402-information-storage-and-management-nov-2019.pdf'
      ),
       Paper(
        paparName: "Computer Graphics & Multimedia",
        year: "dec 2019",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-403-computer-graphics-and-multimedia-nov-2019.pdf'
      ),
       Paper(
        paparName: "Design & Analysis of Algorithm",
        year: "dec 2019",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca-404-design-and-analysis-of-algorithms-nov-2019.pdf'
      ),

      // may2019
      Paper(
        paparName: "Artificial Intelligence & Applications",
        year: "may 2019",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-401-artificial-intelligence-and-applications-may-2019.pdf'
      ),
      Paper(
        paparName: "Information Storage & Management",
        year: "may 2019",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-402-information-storage-and-management-may-2019.pdf'
      ),
      Paper(
        paparName: "Computer Graphics & Multimedia",
        year: "may 2019",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-403-computer-graphics-and-multimedia-may-2019.pdf'
      ),
      Paper(
        paparName: "Design & Analysis of Algorithm",
        year: "may 2019",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-404-design-and-analysis-of-algorithms-may-2019.pdf'
      ),
      Paper(
        paparName: "Java Programming",
        year: "may 2019",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-405-java-programming-and-technologies-may-2019.pdf'
      ),

      // 2018
       Paper(
        paparName: "Artificial Intelligence & Applications",
        year: "may 2018",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-4-sem-artificial-intelligence-and-applications-may-2018.pdf'
      ),
      Paper(
        paparName: "Information Storage & Management",
        year: " may 2018",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-4-sem-information-storage-and-management-may-2018.pdf'
      ),
      Paper(
        paparName: "Computer Graphics & Multimedia",
        year: " may 2018",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-4-sem-computer-graphics-and-mutimedia-may-2018.pdf'
      ),
      Paper(
        paparName: "Design & Analysis of Algorithm",
        year: " may 2018",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-4-sem-design-and-analysis-of-algorithms-may-2018.pdf'
      ),
      Paper(
        paparName: "Java Programming",
        year: "may 2018",
        semester: 4,
        url: 'http://www.rgpvonline.com/papers/mca/mca-4-sem-java-programming-and-technologies-may-2018.pdf'
      ),
  
    ]
  ];
}
