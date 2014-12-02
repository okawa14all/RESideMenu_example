class LeftMenuControllerStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed, example:
  include RoomCellStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.clear
  end

  def rooms_table_view(st)
    st.frame = { l: 0, t: 50, w: app_width - 50, h: app_height - 50 }
    st.background_color = color.clear
  end
end
