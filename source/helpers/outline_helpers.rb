require 'date'
require 'pathname'
module OutlineHelpers
  def outlines(resources=sitemap.resources)
    resources.select   { |resource| resource.data[:layout] == 'outline' }
  end

  # an outline's path takes the form "outlines/yyyy-mm-dd.html"
  def outline_date(outline_path)
    Date.parse(
      Pathname.new(outline_path)
              .basename
              .sub_ext('')
              .to_s
    )
  end
end
