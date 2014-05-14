module CommentHelpers
  # Implements the Paul Irish IE conditional comments HTML tag--in HAML.
  # http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/
  # Usage, instead of %html use:
  # != cc_html do
  def cc_html(options={}, &blk)
    attrs = options.map { |k, v| " #{h k}='#{h v}'" }.join('')
    [ "<!--[if lt IE 7 ]> <html#{attrs} class='ie lt-ie7 no-js'> <![endif]-->",
      "<!--[if IE 7 ]>    <html#{attrs} class='ie ie7 no-js'> <![endif]-->",
      "<!--[if IE 8 ]>    <html#{attrs} class='ie ie8 no-js'> <![endif]-->",
      "<!--[if IE 9 ]>    <html#{attrs} class='ie ie9 no-js'> <![endif]-->",
      "<!--[if (gt IE 9)|!(IE)]><!--> <html#{attrs} class='no-js'> <!--<![endif]-->",
      capture_haml(&blk).strip,
      "</html>"
    ].join("\n")
  end

  def h(str)
    Rack::Utils.escape_html(str)
  end
end
