class RoomCell < UITableViewCell

  def rmq_build
    q = rmq(self.contentView)
    @name = q.build(self.textLabel, :cell_label).get
  end

  def update(room)
    @name.text = room[:name]
  end

end
