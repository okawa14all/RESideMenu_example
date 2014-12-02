class LeftMenuController < UIViewController
  ROOM_CELL_ID = "RoomCell"

  # ---------- viewcontroller life cycle ----------
  def viewDidLoad
    puts "[R] viewDidLoad"
    super

    rmq.stylesheet = LeftMenuControllerStylesheet
    rmq(self.view).apply_style :root_view

    @rooms_table_view = rmq.append(UITableView, :rooms_table_view).get.tap do |tv|
      tv.delegate = self
      tv.dataSource = self
    end

    @indicator_view = MONActivityIndicatorView.new
    point = self.view.center
    @indicator_view.center = CGPointMake(point.x - 50, point.y / 2)
    self.view.addSubview(@indicator_view)

  end

  def viewWillAppear(animated)
    puts "[L] viewWillAppear"
    super
  end

  def viewDidAppear(animated)
    puts "[L] viewDidAppear"
    super
  end

  def viewWillDisappear(animated)
    puts "[L] viewWillDisappear"
    super
  end

  def viewDidDisappear(animated)
    puts "[L] viewDidDisappear"
    super
  end

  # ---------- Menu Methods ----------
  def will_show_menu
    puts '[L] will_show_menu'
    load_rooms
  end

  def did_show_menu
    puts '[L] did_show_menu'
  end

  # ---------- UITableViewDataSource delegates ----------
  def tableView(table_view, numberOfRowsInSection: section)
    @rooms.present? ? @rooms.length : 0
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    rmq.stylesheet.room_cell_height
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    room = @rooms[index_path.row]
    cell = table_view.dequeueReusableCellWithIdentifier(ROOM_CELL_ID) || begin
      rmq.create(
        RoomCell, :room_cell,
        reuse_identifier: ROOM_CELL_ID,
        cell_style: UITableViewCellStyleDefault
      ).get
    end
    cell.update(room)
    cell
  end

  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    current_room = self.sideMenuViewController.delegate.current_room
    selected_room = @rooms[index_path.row]
    if selected_room[:id] != current_room[:id]
      self.sideMenuViewController.delegate.current_room = selected_room
    end
    self.sideMenuViewController.hideMenuViewController
  end

  private

  def load_rooms
    puts '[L] load_rooms'
    rmq(@rooms_table_view).hide
    @indicator_view.startAnimating

    @rooms = rmq.app.delegate.rooms
    @rooms_table_view.reloadData

    @indicator_view.stopAnimating
    rmq(@rooms_table_view).show
  end
end
