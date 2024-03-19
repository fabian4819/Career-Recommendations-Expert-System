; ? Career Recommendation Expert System
; ? Made by
; ? Habib Fabian Fahlesi
; ? 22/505501/TK/55319

;(
;    deftemplate data
;       (slot done-greeting)
;      (multislot recommendations)
;)

; ? fields
; (slot likes-analytics)
; (slot likes-science)
; (slot likes-art)
; (slot likes-helping)
; (slot likes-affect)

; ? subfields
    ; ? analytics
    ; (slot likes-researcher)
    ; (slot likes-IT)
    ; (slot likes-teach)
    ; (slot likes-cyber)

    ; ? science
    ; (slot likes-mechanical)
    ; (slot likes-build)
    ; (slot likes-electrical)
    ; (slot likes-chemical)

    ; ? art
    ; (slot likes-multimedia)
    ; (slot likes-film)
    ; (slot likes-paint)
    ; (slot likes-music)

    ; ? helping
    ; (slot likes-psychology)
    ; (slot likes-doctor)
    ; (slot likes-safety)
    ; (slot likes-animal)

    ; ? affect
    ; (slot likes-sales)
    ; (slot likes-business)
    ; (slot likes-lawyer)
    ; (slot likes-counselor)

; ? Greeting
(
    defrule greet
    =>
    (printout t crlf "Halo, saya Career Recommendation Expert System. Dibuat oleh Habib Fabian Fahlesi." crlf)
    (printout t "Saya akan memberikan anda beberapa pertanyaan dan kemudian saya akan memberikan rekomendasi karir yang cocok sesuai jawaban." crlf crlf)
    (assert (done-greeting yes))
)

(deffunction CF (?value)
   (return ?value)
)

; ? Questions
(
    defrule ask-desire
    (done-greeting yes)
    =>
    ; give users 4 options, 1= Memiliki Karakter Analitis, 2= Suka dengan Penerapan Ilmu secara Langsung, 3= Tertarik dengan dunia seni, 4= Suka dengan hal-hal yang bermanfaat bagi orang lain, 5= Suka memengaruhi/mengajak orang lain dalam hal tertentu
    (printout t "Apa yang lebih anda sukai?" crlf)
    (printout t "1. Memiliki Karakter Analitis" crlf)
    (printout t "2. Suka dengan Penerapan Ilmu secara Langsung" crlf)
    (printout t "3. Tertarik dengan dunia seni" crlf)
    (printout t "4. Suka dengan hal-hal yang bermanfaat bagi orang lain" crlf)
    (printout t "5. Suka memengaruhi/mengajak orang lain dalam hal tertentu" crlf)
    (bind ?input (read))
    (if (eq ?input 1)
        then
        (assert (likes-analytics yes (CF 1.0)))
        (assert (likes-science no (CF 1.0)))
        (assert (likes-art no (CF 1.0)))
        (assert (likes-helping no (CF 1.0)))
        (assert (likes-affect no (CF 1.0)))
        else
        (if (eq ?input 2)
            then
            (assert (likes-analytics no (CF 1.0)))
            (assert (likes-science yes (CF 1.0)))
            (assert (likes-art no (CF 1.0)))
            (assert (likes-helping no (CF 1.0)))
            (assert (likes-affect no (CF 1.0)))
            else
            (if (eq ?input 3)
                then
                (assert (likes-analytics no (CF 1.0)))
                (assert (likes-science no (CF 1.0)))
                (assert (likes-art yes (CF 1.0)))
                (assert (likes-helping no (CF 1.0)))
                (assert (likes-affect no (CF 1.0)))
                else
                (if (eq ?input 4)
                    then
                    (assert (likes-analytics no (CF 1.0)))
                    (assert (likes-science no (CF 1.0)))
                    (assert (likes-art no (CF 1.0)))
                    (assert (likes-helping yes (CF 1.0)))
                    (assert (likes-affect no (CF 1.0)))
                    else
                    (assert (likes-analytics no (CF 1.0)))
                    (assert (likes-science no (CF 1.0)))
                    (assert (likes-art no (CF 1.0)))
                    (assert (likes-helping no (CF 1.0)))
                    (assert (likes-affect yes (CF 1.0)))
                )
            )
        )
    )
)

; ! analytics
; Rule 1
(
    defrule ask-expert
    (likes-analytics yes ?cf-anal)
    =>
    (if (> ?cf-anal 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1.0      
Berapa tingkat ketertarikan anda dengan ilmu-ilmu dasar? (0 s/d 1)" crlf)
        (bind ?cf-expert (read))
        (if (and (>= ?cf-expert 0.5) (<= ?cf-expert 1))
            then
            (assert (likes-expert yes (CF ?cf-expert)))
        )
        (if (and (>= ?cf-expert 0) (< ?cf-expert 0.5))
            then
            (assert (likes-expert no (CF ?cf-expert)))
        )
    )
)


; Rule 2
(
    defrule ask-teach-researcher
    (likes-expert yes ?cf-expert)
    =>
    (if (> ?cf-expert 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan ajar-mengajar? (0 s/d 1)" crlf)
        (bind ?cf-teach (read))
        (if (and (>= ?cf-teach 0.5) (<= ?cf-teach 1))
            then
            (bind ?cf-researcher (- 1 ?cf-teach))
            (assert (likes-researcher yes (CF ?cf-researcher)) (likes-teach yes (CF ?cf-teach)))
        )
        (if (and (>= ?cf-teach 0) (< ?cf-teach 0.5))
            then
            (bind ?cf-researcher (- 1 ?cf-teach))
            (assert (likes-researcher yes (CF ?cf-researcher)) (likes-teach yes (CF ?cf-teach)))
        )
    )
)

; Rule 3
(
    defrule ask-IT-cyber
    (likes-expert no ?cf-expert)
    =>
    (if (> ?cf-expert 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan dunia keamanan data? (0 s/d 1)" crlf)
        (bind ?cf-cyber (read))
        (if (and (>= ?cf-cyber 0.5) (<= ?cf-cyber 1))
            then
            (bind ?cf-IT (- 1 ?cf-cyber))
            (assert (likes-IT yes (CF ?cf-IT)) (likes-cyber yes (CF ?cf-cyber)))
        )
        (if (and (>= ?cf-cyber 0) (< ?cf-cyber 0.5))
            then
            (bind ?cf-IT (- 1 ?cf-cyber))
            (assert (likes-IT yes (CF ?cf-IT)) (likes-cyber yes (CF ?cf-cyber)))
        )
    )
)

; ! science
; Rule 4
(
    defrule ask-manufactur
    (likes-science yes ?cf-science)
    =>
    (if (> ?cf-science 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda membuat sesuatu di bidang manufaktur? (0 s/d 1)" crlf)
        (bind ?cf-manuf (read))
        (if (and (>= ?cf-manuf 0.5) (<= ?cf-manuf 1))
            then
            (assert (likes-manufactur yes (CF ?cf-manuf)))
        )
        (if (and (>= ?cf-manuf 0) (< ?cf-manuf 0.5))
            then
            (assert (likes-manufactur no (CF ?cf-manuf)))
        )
    )
)

; Rule 5
(
    defrule ask-mechanical-build
    (likes-manufactur yes ?cf-manuf)
    =>
    (if (> ?cf-manuf 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan hal-hal yang terkait dengan bangunan? (0 s/d 1)" crlf)
        (bind ?cf-build (read))
        (if (and (>= ?cf-build 0.5) (<= ?cf-build 1))
            then
            (bind ?cf-mech (- 1 ?cf-build))
            (assert (likes-mechanical yes (CF ?cf-mech)) (likes-build yes (CF ?cf-build)))
        )
        (if (and (>= ?cf-build 0) (< ?cf-build 0.5))
            then
            (bind ?cf-mech (- 1 ?cf-build))
            (assert (likes-mechanical yes (CF ?cf-mech)) (likes-build yes (CF ?cf-build)))
        )
    )
)

; Rule 6
(
    defrule ask-elec-chemical
    (likes-manufactur no ?cf-manuf)
    =>
    (if (> ?cf-manuf 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan zat-zat tertentu? (0 s/d 1)" crlf)
        (bind ?cf-chem (read))
        (if (and (>= ?cf-chem 0.5) (<= ?cf-chem 1))
            then
            (bind ?cf-elec (- 1 ?cf-chem))
            (assert (likes-electrical yes (CF ?cf-elec)) (likes-chemical yes (CF ?cf-chem)))
        )
        (if (and (>= ?cf-chem 0) (< ?cf-chem 0.5))
            then
            (bind ?cf elec (- 1 ?cf-chem))
            (assert (likes-electrical yes (CF ?cf-elec)) (likes-chemical yes (CF ?cf-chem)))
        )
    )
)

; ! art
; Rule 7
(
    defrule ask-video
    (likes-art yes ?cf-art)
    =>
    (if (> ?cf-art 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan pembuatan suatu video? (0 s/d 1)" crlf)
        (bind ?cf-video (read))
        (if (and (>= ?cf-video 0.5) (<= ?cf-video 1))
            then
            (assert (likes-video yes (CF ?cf-video)))
        )
        (if (and (>= ?cf-video 0) (< ?cf-video 0.5))
            then
            (assert (likes-video no (CF ?cf-video)))
        )
    )
)

; Rule 8
(
    defrule ask-mulmed-film
    (likes-video yes ?cf-video)
    =>
    (if (> ?cf-video 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan proses syuting film-film yang anda tonton? (0 s/d 1)" crlf)
        (bind ?cf-film (read))
        (if (and (>= ?cf-film 0.5) (<= ?cf-film 1))
            then
            (bind ?cf-multimedia (- 1 ?cf-film))
            (assert (likes-multimedia yes (CF ?cf-multimedia)) (likes-film yes (CF ?cf-film)))
        )
        (if (and (>= ?cf-film 0) (< ?cf-film 0.5))
            then
            (bind ?cf-multimedia (- 1 ?cf-film))
            (assert (likes-multimedia yes (CF ?cf-multimedia)) (likes-film yes (CF ?cf-film)))
        )
    )
)

; Rule 9
(
    defrule ask-paint-music
    (likes-video no ?cf-video)
    =>
    (if (> ?cf-video 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan musik? (0 s/d 1)" crlf)
        (bind ?cf-music (read))
        (if (and (>= ?cf-music 0.5) (<= ?cf-music 1))
            then
            (bind ?cf-paint (- 1 ?cf-music))
            (assert (likes-paint yes (CF ?cf-paint)) (likes-music yes (CF ?cf-music)))
        )
        (if (and (>= ?cf-music 0) (< ?cf-music 0.5))
            then
            (bind ?cf-paint (- 1 ?cf-music))
            (assert (likes-paint yes (CF ?cf-paint)) (likes-music yes (CF ?cf-music)))
        )
    )
)

; ! helping
; Rule 10
(
    defrule ask-health
    (likes-helping yes ?cf-helping)
    =>
    (if (> ?cf-helping 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan dunia kesehatan? (0 s/d 1)" crlf)
        (bind ?cf-health (read))
        (if (and (>= ?cf-health 0.5) (<= ?cf-health 1))
            then
            (assert (likes-health yes (CF ?cf-health)))
        )
        (if (and (>= ?cf-health 0) (< ?cf-health 0.5))
            then
            (assert (likes-health no (CF ?cf-health)))
        )
    )
)

; Rule 11
(
    defrule ask-doctor-animal
    (likes-health yes ?cf-health)
    =>
    (if (> ?cf-health 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketakutan anda dengan hewan? (0 s/d 1)" crlf)
        (bind ?cf-doctor (read))
        (if (and (>= ?cf-doctor 0.5) (<= ?cf-doctor 1))
            then
            (bind ?cf-animal (- 1 ?cf-doctor))
            (assert (likes-animal yes (CF ?cf-animal)) (likes-doctor yes (CF ?cf-doctor)))
        )
        (if (and (>= ?cf-doctor 0) (< ?cf-doctor 0.5))
            then
            (bind ?cf-animal (- 1 ?cf-doctor))
            (assert (likes-animal yes (CF ?cf-animal)) (likes-doctor yes (CF ?cf-doctor)))
        )
    )
)

; Rule 12
(
    defrule ask-psychology-safety
    (likes-health no ?cf-health)
    =>
    (if (> ?cf-health 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda bekerja di lapangan? (0 s/d 1)" crlf)
        (bind ?cf-safety (read))
        (if (and (>= ?cf-safety 0.5) (<= ?cf-safety 1))
            then
            (bind ?cf-psychology (- 1 ?cf-safety))
            (assert (likes-psychology yes (CF ?cf-psychology)) (likes-safety yes (CF ?cf-safety)))
        )
        (if (and (>= ?cf-safety 0) (< ?cf-safety 0.5))
            then
            (bind ?cf-psychology (- 1 ?cf-safety))
            (assert (likes-psychology yes (CF ?cf-psychology)) (likes-safety yes (CF ?cf-safety)))
        )
    )
)

; ! affect
; Rule 13
(
    defrule ask-corporate
    (likes-affect yes ?cf-affect)
    =>
    (if (> ?cf-affect 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan dunia bisnis atau sebuah perusahaan? (0 s/d 1)" crlf)
        (bind ?cf-corporate (read))
        (if (and (>= ?cf-corporate 0.5) (<= ?cf-corporate 1))
            then
            (assert (likes-corporate yes (CF ?cf-corporate)))
        )
        (if (and (>= ?cf-corporate 0) (< ?cf-corporate 0.5))
            then
            (assert (likes-corporate no (CF ?cf-corporate)))
        )
    )
)

; Rule 14
(
    defrule ask-sales-business
    (likes-corporate yes ?cf-corporate)
    =>
    (if (> ?cf-corporate 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan jabatan yang tinggi? (0 s/d 1)" crlf)
        (bind ?cf-business (read))
        (if (and (>= ?cf-business 0.5) (<= ?cf-business 1))
            then
            (bind ?cf-sales (- 1 ?cf-business))
            (assert (likes-sales yes (CF ?cf-sales)) (likes-business yes (CF ?cf-business)))
        )
        (if (and (>= ?cf-business 0) (< ?cf-business 0.5))
            then
            (bind ?cf-sales (- 1 ?cf-business))
            (assert (likes-sales yes (CF ?cf-sales)) (likes-business yes (CF ?cf-business)))
        )
    )
)


; Rule 15
(
    defrule ask-lawyer-counselor
    (likes-corporate no ?cf-corporate)
    =>
    (if (> ?cf-corporate 0)
        then
        (printout t "
        Unknown                 : 0 to 0.2
        Maybe                   : 0.4
        Probably                : 0.6
        Almost certainly        : 0.8
        Definitely              : 1
Berapa tingkat ketertarikan anda dengan dunia hukum? (0 s/d 1)" crlf)
        (bind ?cf-lawyer (read))
        (if (and (>= ?cf-lawyer 0.5) (<= ?cf-lawyer 1))
            then
            (bind ?cf-counselor (- 1 ?cf-lawyer))
            (assert (likes-counselor yes (CF ?cf-counselor)) (likes-lawyer yes (CF ?cf-lawyer)))
        )
        (if (and (>= ?cf-lawyer 0) (< ?cf-lawyer 0.5))
            then
            (bind ?cf-counselor (- 1 ?cf-lawyer))
            (assert (likes-counselor yes (CF ?cf-counselor)) (likes-lawyer yes (CF ?cf-lawyer)))
        )
    )
)


; ? Recommendations
(defrule researcher
   (likes-expert yes ?cf-expert)
   (likes-researcher yes ?cf-researcher)
   =>
   (if (and (>= ?cf-expert 0) (>= ?cf-researcher 0.5))
      then
      (bind ?cf-total (+ ?cf-expert (* ?cf-researcher (- 1 ?cf-expert))))
      (assert (likes-researcher yes (CF ?cf-total)))
   )

   (printout t "==============================================================================" crlf)
   (printout t "Rekomendasi Karir dengan kepastian " ?cf-total " untuk Anda : " crlf)
   (printout t "1. Ahli (Fisika, Kimia, Biologi, Matematika)" crlf)
   (printout t "2. Peneliti" crlf)
   (printout t "3. Periset" crlf)
   (printout t "==============================================================================" crlf)
)


(
    defrule IT
    (likes-expert no ?cf-expert)
    (likes-IT yes ?cf-IT)
    =>
    (if (and (>= ?cf-expert 0) (>= ?cf-IT 0.5))
        then
        (bind ?cf-total (+ ?cf-expert (* ?cf-IT (- 1 ?cf-expert))))
        (assert (likes-IT yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Programmer" crlf)
    (printout t "2. IT Developer" crlf)
    (printout t "3. Data Scientist" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule teach
    (likes-expert yes ?cf-expert)
    (likes-teach yes ?cf-teach)
    =>
    (if (and (>= ?cf-expert 0) (>= ?cf-teach 0))
        then
        (bind ?cf-total (+ ?cf-expert (* ?cf-teach (- 1 ?cf-expert))))
        (assert (likes-teach yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total " untuk Anda : " crlf)
    (printout t "1. Guru" crlf)
    (printout t "2. Dosen" crlf)
    (printout t "3. Pengajar" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule cyber
    (likes-expert no ?cf-expert)
    (likes-cyber yes ?cf-cyber)
    =>
    (if (and (>= ?cf-expert 0) (>= ?cf-cyber 0.5))
        then
        (bind ?cf-total (+ ?cf-expert (* ?cf-cyber (- 1 ?cf-expert))))
        (assert (likes-cyber yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Cyber Security" crlf)
    (printout t "2. Ethical Hacker" crlf)
    (printout t "3. Penetration Tester" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule mechanical
    (likes-manufactur yes ?cf-manuf)
    (likes-mechanical yes ?cf-mech)
    =>
    (if (and (>= ?cf-manuf 0) (>= ?cf-mech 0.5))
        then
        (bind ?cf-total (+ ?cf-manuf (* ?cf-mech (- 1 ?cf-manuf))))
        (assert (likes-mechanical yes (CF ?cf-total)))
    )

    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Insinyur Mesin" crlf)
    (printout t "2. Operator Mesin" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule build
    (likes-manufactur yes ?cf-manuf)
    (likes-build yes ?cf-build)
    =>
    (if (and (>= ?cf-manuf 0) (>= ?cf-build 0.5))
        then
        (bind ?cf-total (+ ?cf-manuf (* ?cf-build (- 1 ?cf-manuf))))
        (assert (likes-build yes (CF ?cf-total)))
    )

    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Arsitek" crlf)
    (printout t "2. Kontraktor" crlf)
    (printout t "3. Insinyur Sipil" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule electrical
    (likes-manufactur no ?cf-manuf)
    (likes-electrical yes ?cf-elec)
    =>
    (if (and (>= ?cf-manuf 0) (>= ?cf-elec 0.5))
        then
        (bind ?cf-total (+ ?cf-manuf (* ?cf-elec (- 1 ?cf-manuf))))
        (assert (likes-electrical yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Insinyur Listrik" crlf)
    (printout t "2. Elektronis" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule chemical
    (likes-manufactur no ?cf-manuf)
    (likes-chemical yes ?cf-chem)
    =>
    (if (and (>= ?cf-manuf 0) (>= ?cf-chem 0.5))
        then
        (bind ?cf-total (+ ?cf-manuf (* ?cf-chem (- 1 ?cf-manuf))))
        (assert (likes-chemical yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Laboran" crlf)
    (printout t "2. Peneliti Kimia" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule multimedia
    (likes-video yes ?cf-video)
    (likes-multimedia yes ?cf-multimedia)
    =>
    (if (and (>= ?cf-video 0) (>= ?cf-multimedia 0.5))
        then
        (bind ?cf-total (+ ?cf-video (* ?cf-multimedia (- 1 ?cf-video))))
        (assert (likes-multimedia yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Desainer Grafis" crlf)
    (printout t "2. Animator" crlf)
    (printout t "3. Fotografer" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule film
    (likes-video yes ?cf-video)
    (likes-film yes ?cf-film)
    =>
    (if (and (>= ?cf-video 0) (>= ?cf-film 0.5))
        then
        (bind ?cf-total (+ ?cf-video (* ?cf-film (- 1 ?cf-video))))
        (assert (likes-film yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Sutradara" crlf)
    (printout t "2. Penulis Naskah" crlf)
    (printout t "3. Editor Video" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule paint
    (likes-video no ?cf-video)
    (likes-paint yes ?cf-paint)
    =>
    (if (and (>= ?cf-video 0) (>= ?cf-paint 0.5))
        then
        (bind ?cf-total (+ ?cf-video (* ?cf-paint (- 1 ?cf-video))))
        (assert (likes-paint yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Pelukis" crlf)
    (printout t "2. Desainer Interior" crlf)
    (printout t "3. Desainer Fashion" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule music
    (likes-video no ?cf-video)
    (likes-music yes ?cf-music)
    =>
    (if (and (>= ?cf-video 0) (>= ?cf-music 0.5))
        then
        (bind ?cf-total (+ ?cf-video (* ?cf-music (- 1 ?cf-video))))
        (assert (likes-music yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Musisi" crlf)
    (printout t "2. Komposer" crlf)
    (printout t "3. Penyanyi" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule psychology
    (likes-health no ?cf-health)
    (likes-psychology yes ?cf-psychology) 
    =>
    (if (and (>= ?cf-health 0) (>= ?cf-psychology 0.5))
        then
        (bind ?cf-total (+ ?cf-health (* ?cf-psychology (- 1 ?cf-health))))
        (assert (likes-psychology yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Psikolog" crlf)
    (printout t "2. Psikiater" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule doctor
    (likes-health yes ?cf-health)
    (likes-doctor yes ?cf-doctor)
    =>
    (if (and (>= ?cf-health 0) (>= ?cf-doctor 0.5))
        then
        (bind ?cf-total (+ ?cf-health (* ?cf-doctor (- 1 ?cf-health))))
        (assert (likes-doctor yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Dokter" crlf)
    (printout t "2. Perawat" crlf)
    (printout t "3. Bidan" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule safety
    (likes-health no ?cf-health)
    (likes-safety yes ?cf-safety)
    =>
    (if (and (>= ?cf-health 0) (>= ?cf-safety 0.5))
        then
        (bind ?cf-total (+ ?cf-health (* ?cf-safety (- 1 ?cf-health))))
        (assert (likes-safety yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Polisi" crlf)
    (printout t "2. Pemadam Kebakaran" crlf)
    (printout t "3. Petugas SAR" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule animal
    (likes-health yes ?cf-health)
    (likes-animal yes ?cf-animal)
    =>
    (if (and (>= ?cf-health 0) (>= ?cf-animal 0.5))
        then
        (bind ?cf-total (+ ?cf-health (* ?cf-animal (- 1 ?cf-health))))
        (assert (likes-animal yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Dokter Hewan" crlf)
    (printout t "2. Penjaga Kebun Binatang" crlf)
    (printout t "3. Peneliti Hewan" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule sales
    (likes-corporate yes ?cf-corporate)
    (likes-sales yes ?cf-sales)
    =>
    (if (and (>= ?cf-corporate 0) (>= ?cf-sales 0.5))
        then
        (bind ?cf-total (+ ?cf-corporate (* ?cf-sales (- 1 ?cf-corporate))))
        (assert (likes-sales yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Sales" crlf)
    (printout t "2. Marketing" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule business
    (likes-corporate yes ?cf-corporate)
    (likes-business yes ?cf-business)
    =>
    (if (and (>= ?cf-corporate 0) (>= ?cf-business 0.5))
        then
        (bind ?cf-total (+ ?cf-corporate (* ?cf-business (- 1 ?cf-corporate))))
        (assert (likes-business yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Pengusaha" crlf)
    (printout t "2. Manajer" crlf)
    (printout t "3. Eksekutif" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule lawyer
    (likes-corporate no ?cf-corporate)
    (likes-lawyer yes ?cf-lawyer)
    =>
    (if (and (>= ?cf-corporate 0) (>= ?cf-lawyer 0.5))
        then
        (bind ?cf-total (+ ?cf-corporate (* ?cf-lawyer (- 1 ?cf-corporate))))
        (assert (likes-lawyer yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Pengacara" crlf)
    (printout t "2. Hakim" crlf)
    (printout t "3. Notaris" crlf)
    (printout t "==============================================================================" crlf)
)

(
    defrule counselor
    (likes-corporate no ?cf-corporate)
    (likes-couselor yes ?cf-counselor)
    =>
    (if (and (>= ?cf-corporate 0) (>= ?cf-counselor 0.5))
        then
        (bind ?cf-total (+ ?cf-corporate (* ?cf-counselor (- 1 ?cf-corporate))))
        (assert (likes-counselor yes (CF ?cf-total)))
    )
    (printout t "==============================================================================" crlf)
    (printout t "Rekomendasi Karir dengan nilai kepastian" ?cf-total "untuk Anda : " crlf)
    (printout t "1. Motivator" crlf)
    (printout t "2. Conselor" crlf)
    (printout t "==============================================================================" crlf)
)



