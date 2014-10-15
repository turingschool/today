module OutlineListHelpers
  def outline_list(resources)
    resources.select {|r| r.data.layout == 'outline'}\
             .sort_by {|o| outline_name(o.path)}\
             .reverse
  end

  def outline_name(path)
    path.split('/').last.split('.').first
  end
end
