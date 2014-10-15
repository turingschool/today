module OutlineListHelpers
  def outline_list(resources)
    resources.select  { |resource| resource.data.layout == 'outline' }
             .sort_by { |outline| outline_name(outline.path) }
             .reverse
  end

  def outline_name(path)
    path.split('/').last.split('.').first
  end
end
