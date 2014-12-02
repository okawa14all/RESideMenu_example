module RoomCellStylesheet

  def room_cell_height
    80
  end

  def room_cell(st)
    st.background_color = color.clear
    st.view.selectionStyle = UITableViewCellSelectionStyleNone
  end

  def cell_label(st)
    st.color = color.white
  end

end
