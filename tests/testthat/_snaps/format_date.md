# Test format date

    Code
      format_date("2019")
    Output
      [1] "2019"

---

    Code
      format_date("2019-04-20")
    Output
      [1] "20APR2019"

---

    Code
      format_date("")
    Output
      [1] ""

---

    Code
      format_date("2019-06-18T10:32")
    Output
      [1] "18JUN2019"

---

    Code
      format_date("2019-04")
    Output
      [1] "APR2019"

