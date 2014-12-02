class RightMenuController < UIViewController
  MEMBER_CELL_ID = "MemberCell"
  attr_accessor :members

  # ---------- viewcontroller life cycle ----------
  def viewDidLoad
    puts "[R] viewDidLoad"
    super

    rmq.stylesheet = RightMenuControllerStylesheet
    rmq(self.view).apply_style :root_view

    @members_table_view = rmq.append(UITableView, :members_table_view).get.tap do |tv|
      tv.delegate = self
      tv.dataSource = self
    end

    @indicator_view = MONActivityIndicatorView.new
    point = self.view.center
    @indicator_view.center = CGPointMake(point.x + 50, point.y / 2)
    self.view.addSubview(@indicator_view)

  end

  def viewWillAppear(animated)
    puts "[R] viewWillAppear"
    super
  end

  def viewDidAppear(animated)
    puts "[R] viewDidAppear"
    super
  end

  def viewWillDisappear(animated)
    puts "[R] viewWillDisappear"
    super
  end

  def viewDidDisappear(animated)
    puts "[R] viewDidDisappear"
    super
  end

  # ---------- Action Methods ----------
  def will_show_menu
    puts '[R] will_show_menu'
    load_members
  end

  def did_show_menu
    puts '[R] did_show_menu'
  end

  # ---------- UITableViewDataSource delegates ----------
  def tableView(table_view, numberOfRowsInSection: section)
    @members.present? ? @members.length : 0
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    rmq.stylesheet.member_cell_height
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    member = @members[index_path.row]
    cell = table_view.dequeueReusableCellWithIdentifier(MEMBER_CELL_ID) || begin
      rmq.create(
        MemberCell, :member_cell,
        reuse_identifier: MEMBER_CELL_ID,
        cell_style: UITableViewCellStyleDefault
      ).get
    end
    cell.update(member)
    cell
  end

  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    puts "[R] #{@members[index_path.row]} tapped"
  end

  private

  def load_members
    puts '[R] load_members'
    rmq(@members_table_view).hide
    @indicator_view.startAnimating

    @members_table_view.reloadData

    @indicator_view.stopAnimating
    rmq(@members_table_view).show
  end
end
