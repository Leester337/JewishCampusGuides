module CollegesHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def jewishMajorMinor()
    jewishAcad = ""
    if (@college.jewishMajor == true)
      if (@college.jewishMinor == true)
        jewishAcad = "Minor and major available"
      else
        jewishAcad = "Major available"
      end
    elsif (@college.jewishMinor == true)
      jewishAcad = "Minor available"
    else jewishAcad = "No Jewish degrees available"
    end

    return jewishAcad
  end

end
