# Generates the static site into ./site from shared template + page bodies.
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$out = Join-Path $root 'site'
New-Item -ItemType Directory -Force "$out\images","$out\files" | Out-Null

# Assets
Copy-Item "$root\uploads\uploads\2020\03\rachel-1.jpeg" "$out\images\rachel.jpeg" -Force
Copy-Item "$root\uploads\uploads\2010\07\cropped-header.jpg" "$out\images\header.jpg" -Force
Copy-Item "$root\uploads\uploads\ET-New-Client-Forms.pdf" "$out\files\ET-New-Client-Forms.pdf" -Force

$nav = @(
  @('index.html','Home'), @('about.html','About Me'), @('services.html','Services'),
  @('expectations.html','What to Expect'), @('forms.html','Forms'),
  @('resources.html','Resources'), @('contact.html','Contact')
)

$footer = @'
<address>
  <strong>Rachel Rabideau, M.A., ET/P</strong><br>
  38 W. Sierra Madre Blvd. Suite L, Sierra Madre, CA 91024<br>
  Phone: <a href="tel:+16264875628">626.487.5628</a><br>
  Email: <a href="mailto:rachel@rabideau.org">rachel@rabideau.org</a>
</address>
'@

function Build($file, $title, $body, $desc, $hero = '') {
  $links = ($nav | % {
    $cur = if ($_[0] -eq $file) { ' aria-current="page"' } else { '' }
    "<a href=`"$($_[0])`"$cur>$($_[1])</a>"
  }) -join "`n        "
  $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$title | Foothill Village Educational Therapy</title>
  <meta name="description" content="$desc">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <header class="site-header">
    <div class="wrap bar">
      <a class="brand" href="index.html">
        <span class="brand-name">Rachel Rabideau, M.A., ET/P</span>
        <span class="brand-sub">Foothill Village Educational Therapy</span>
      </a>
      <input type="checkbox" id="nav-toggle" class="nav-toggle" aria-label="Toggle menu">
      <label for="nav-toggle" class="nav-btn" aria-hidden="true"><span></span></label>
      <nav>
        $links
      </nav>
    </div>
  </header>
$hero
  <main class="wrap content">
    <h1>$title</h1>
$body
  </main>
  <footer class="site-footer">
    <div class="wrap">
$footer
    </div>
  </footer>
</body>
</html>
"@
  Set-Content -Path "$out\$file" -Value $html -Encoding UTF8
}

$hero = '  <div class="hero"><img src="images/header.jpg" alt="Rachel Rabideau, M.A., ET/P - Educational Therapy Services"></div>'

Build 'index.html' 'Welcome To My Practice!' @'
    <p class="lead">I am immensely grateful to belong to a profession I feel passionate about and that allows me to connect with amazing students and their families.</p>
    <p class="lead">Blending the fields of education and psychology, educational therapy combines educational, therapeutic, and holistic approaches to evaluate and provide intensive individualized intervention and case management for neurodiverse children, adolescents, and young adults who are experiencing learning difficulties.</p>
    <p class="lead">The primary goal of educational therapy is to provide students an environment in which he/she feels safe, comfortable, and free from anxiety in order to ask questions, take academic risks, learn from mistakes, and thrive to the best of his/her ability. Building rapport and making connections with students and their families is one of the most rewarding aspects of my work.</p>
'@ 'Educational therapy for neurodiverse children, adolescents, and young adults in Sierra Madre, CA.' $hero

Build 'about.html' 'About Me' @'
    <img class="portrait" src="images/rachel.jpeg" alt="Rachel Rabideau" width="226" height="300">
    <p>I am a Professional Educational Therapist (ET/P) in private practice with 30 years of experience supporting students with learning differences in the greater Pasadena area. Before establishing my private practice, my background included classroom teaching in the public schools and clinical work at the Frostig Center in Pasadena. I work with a diverse range of students, including those in local public and private schools as well as homeschoolers.</p>
    <p>On a personal note, I have lived in Southern California for 32 years with my husband and our two college-aged children. In my spare time, I enjoy hiking, yoga, reading, cooking, and spending time with my family and our pets.</p>
    <h2>Professional Credentials</h2>
    <p>I hold California teaching credentials in both general and special education (mild-moderate), as well as a Master of Arts in Special Education with an emphasis in learning disabilities. Additionally, I earned a post-graduate certificate in Educational Therapy. As a professional member of the <em>Association of Educational Therapists</em> (AET), I previously served on the Board of Directors and co-founded the <em>AET San Gabriel Valley Professional Study Group</em> in 2004. I remain committed to continuing education and believe that learning is a lifelong journey.</p>
'@ 'About Rachel Rabideau, M.A., ET/P, Professional Educational Therapist with 30 years of experience.'

Build 'services.html' 'Services' @'
    <p>Educational Therapy services are provided in a professional office setting in the quaint foothill community of Sierra Madre, CA or via Zoom, upon request and when appropriate. One-on-one sessions are typically 50 minutes in length. Sometimes sessions are shorter or longer, depending upon the needs of the client and/or the client's family. In those cases, sessions are prorated. The frequency and duration of therapy varies and is also based upon the individual needs of the client.</p>
    <p>Therapy sessions provide a wide range of intensive, individualized interventions designed to remediate learning difficulties. It is a skill-oriented process whereas tutoring is content-oriented. The purpose of educational therapy is to improve basic learning skills so the client can learn and retain content on his/her own. This often includes strengthening areas of perceptual and cognitive difficulty as well as critical thinking. The methods and programs used are research-based and uniquely selected for each client.</p>
    <p>Therapy sessions include developing the client's use of strengths to foster learning as well as helping him/her understand the social and emotional aspects that impact learning. If a client does not already have the results of an evaluation from a professional, he/she may need a psychological-educational evaluation to determine levels of academic achievement, learning style, and areas of strength and weaknesses used to develop a treatment plan. However, depending upon the scope and level of learning challenges, assessments administered during educational therapy sessions may provide sufficient information to develop an intervention plan.</p>
    <h2>Clients are typically neurodiverse children, adolescents and young adults who struggle with learning difficulties such as:</h2>
    <ul class="chips">
      <li>Dyslexia</li><li>ADHD</li><li>Academic difficulties (reading, written expression, mathematics)</li>
      <li>Language processing problems</li><li>Nonverbal learning disorders (NVLD)</li>
      <li>Visual and auditory processing problems</li><li>Autism spectrum disorder (ASD)</li>
      <li>Executive Function Difficulties</li><li>Poor motivation</li><li>Anxiety</li><li>Low academic self-esteem</li>
    </ul>
'@ 'Educational therapy services in Sierra Madre, CA or via Zoom.'

Build 'expectations.html' 'What to Expect' @'
    <p>What to expect from Educational Therapy sessions:</p>
    <ul class="checks">
      <li>The presence of a safe (and fun!) environment where the client feels safe and comfortable to take risks associated with learning. This is based on a relaxed, supportive, therapeutic relationship between the client/client's family and therapist.</li>
      <li>Consideration of the client's diverse academic, intellectual, and socioemotional needs</li>
      <li>Strengthening the skills that are causing the client difficulty in order to improve independent and effective learning using research-based programs</li>
      <li>Guiding clients and families towards a path that embraces their child's neurodiversity</li>
      <li>Helping parents understand appropriate client expectations</li>
      <li>Identifying and utilizing appropriate compensatory strategies, including assistive technology when necessary, to promote the client's success in the classroom environment</li>
      <li>Utilization of mindfulness techniques to decrease anxiety and/or increase focus</li>
      <li>Understanding the client's learning issues in relation to the client's context, including the home, school, community, and culture</li>
      <li>Demystification of the client's learning disability/learning difference(s), including an understanding of individual strengths and weaknesses</li>
      <li>Assisting the client to effectively use necessary self-advocacy skills</li>
      <li>Collaboration with child's parents, teacher(s), and other professionals involved with the client such as speech and language therapists, occupational therapists, psychologists, and developmental optometrists</li>
      <li>Referral to outside professionals if needed</li>
      <li>Helping parents navigate the request for assessment process in public schools</li>
      <li>Respect for issues of confidentiality</li>
      <li>Frequent and open communication between therapist and parent; therapy is most effective when parents are included in the skills and strategies taught during sessions</li>
    </ul>
'@ 'What to expect from educational therapy sessions.'

Build 'forms.html' 'Forms' @'
    <p>After scheduling an intake meeting, please print and fill out the following forms:</p>
    <ul class="links">
      <li><a href="files/ET-New-Client-Forms.pdf" target="_blank" rel="noopener noreferrer">New Client Forms (PDF)</a></li>
    </ul>
'@ 'New client forms for educational therapy.'

Build 'resources.html' 'Resources' @'
    <ul class="links">
      <li><a href="http://www.aetonline.org" target="_blank" rel="noopener noreferrer">Association of Educational Therapists</a></li>
      <li><a href="http://www.chadd.org" target="_blank" rel="noopener noreferrer">Children and Adults with ADHD</a></li>
      <li><a href="https://www.understood.org/?_sp=7dbbf089-c480-4a93-95e0-3190582fdb65.1647829413789" target="_blank" rel="noopener noreferrer">Understood</a></li>
      <li><a href="https://www.autismspeaks.org/what-autism" target="_blank" rel="noopener noreferrer">Autism Speaks</a></li>
      <li><a href="http://www.interdys.org" target="_blank" rel="noopener noreferrer">The International Dyslexia Association</a></li>
      <li><a href="http://www.reading.org" target="_blank" rel="noopener noreferrer">International Reading Association</a></li>
      <li><a href="http://www.ldanatl.org" target="_blank" rel="noopener noreferrer">Learning Disabilities Association of America</a></li>
      <li><a href="http://www.ldonline.org" target="_blank" rel="noopener noreferrer">Learning Disabilities Online</a></li>
      <li><a href="http://www.ncld.org" target="_blank" rel="noopener noreferrer">National Center for Learning Disabilities</a></li>
      <li><a href="https://www.ldrfa.org/" target="_blank" rel="noopener noreferrer">LD Resources Foundation Action</a></li>
      <li><a href="http://www.wrightslaw.org" target="_blank" rel="noopener noreferrer">Wrights Law</a></li>
    </ul>
'@ 'Helpful organizations and resources for learning differences.'

Build 'contact.html' 'Contact' @'
    <p>Please feel free to contact me via phone or email:</p>
    <p>Phone/text: <a href="tel:+16264875628">626.487.5628</a><br>
    Email: <a href="mailto:rachel@rabideau.org">rachel@rabideau.org</a></p>
    <p><strong>Office Location:</strong><br>38 W. Sierra Madre Blvd. Suite L<br>Sierra Madre, CA 91024</p>
    <div class="map">
      <iframe title="Map to office" loading="lazy" referrerpolicy="no-referrer-when-downgrade" allowfullscreen
        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3301.4027781894183!2d-118.05581108510806!3d34.16161841940636!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x80c2dc70abd9e333%3A0xede2a0baf76823bc!2s38+W+Sierra+Madre+Blvd+Suite+L%2C+Sierra+Madre%2C+CA+91024!5e0!3m2!1sen!2sus!4v1520994892453"></iframe>
    </div>
    <p><a href="https://goo.gl/maps/F6nRY1zuScG2" target="_blank" rel="noopener noreferrer">View Larger Map</a></p>
'@ 'Contact Rachel Rabideau, Educational Therapist in Sierra Madre, CA.'
Write-Host "Built to $out"

