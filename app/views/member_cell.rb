class MemberCell < UITableViewCell

  def rmq_build
    q = rmq(self.contentView)
    @name = q.build(self.textLabel, :cell_label).get
  end

  def update(member)
    @name.text = member
  end

end
