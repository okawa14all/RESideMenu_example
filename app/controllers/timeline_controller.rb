class TimelineController < UIViewController
  include BW::KVO
  attr_accessor :current_room

  # ---------- viewcontroller life cycle ----------
  def viewDidLoad
    puts "[TL] viewDidLoad"
    super
    self.edgesForExtendedLayout = UIRectEdgeNone
    rmq.stylesheet = TimelineControllerStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    @timeline_label = rmq.append(UILabel, :timeline_label).get

    rmq.append(UIToolbar, :toolbar).get.tap do |toolbar|
      toolbar.items = toolbar_buttons
    end

    @indicator_view = MONActivityIndicatorView.new
    point = self.view.center
    @indicator_view.center = CGPointMake(point.x, point.y / 2)
    self.view.addSubview(@indicator_view)

    observe(:current_room) do |old_value, new_value|
      unless old_value == new_value
        puts "[TL] room changed to room_id=#{new_value[:id]} from room_id=#{old_value[:id]}"
        self.sideMenuViewController.rightMenuViewController.members = new_value[:members]
        load_timeline
      end
    end

    load_timeline
  end

  def viewWillAppear(animated)
    puts "[TL] viewWillAppear"
    super
  end

  def viewDidAppear(animated)
    puts "[TL] viewDidAppear"
    super
  end

  def viewWillDisappear(animated)
    puts "[TL] viewWillDisappear"
    super
  end

  def viewDidDisappear(animated)
    puts "[TL] viewDidDisappear"
    super
  end

  def init_nav
    self.title = @current_room[:name]

    right_icon = FAKIonIcons.earthIconWithSize 20
    right_icon.addAttribute(NSForegroundColorAttributeName, value: rmq.color.dark_gray)
    right_icon_image = right_icon.imageWithSize(CGSizeMake(20, 20))
    self.navigationItem.tap do |nav|
      nav.rightBarButtonItem = UIBarButtonItem.alloc.initWithImage(
        right_icon_image.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal),
        style: UIBarButtonItemStylePlain,
        target: self,
        action: :open_notification_controller
      )
    end
  end

  def toolbar_buttons
    left_icon = FAKIonIcons.naviconIconWithSize 30
    left_icon.addAttribute(NSForegroundColorAttributeName, value: rmq.color.black)
    left_icon_image = left_icon.imageWithSize(CGSizeMake(30, 30))
    left_button = UIBarButtonItem.alloc.initWithImage(
      left_icon_image.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal),
      style: UIBarButtonItemStylePlain,
      target: self,
      action: :open_left_menu
    )

    center_icon = FAKIonIcons.plusCircledIconWithSize 30
    center_icon.addAttribute(NSForegroundColorAttributeName, value: rmq.color.black)
    center_icon_image = center_icon.imageWithSize(CGSizeMake(30, 30))
    center_button = UIBarButtonItem.alloc.initWithImage(
      center_icon_image.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal),
      style: UIBarButtonItemStylePlain,
      target: self,
      action: :open_new_post_controller
    )

    right_icon = FAKIonIcons.gearAIconWithSize 30
    right_icon.addAttribute(NSForegroundColorAttributeName, value: rmq.color.black)
    right_icon_image = right_icon.imageWithSize(CGSizeMake(30, 30))
    right_button = UIBarButtonItem.alloc.initWithImage(
      right_icon_image.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal),
      style: UIBarButtonItemStylePlain,
      target: self,
      action: :open_right_menu
    )

    flexible_spacer = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
      UIBarButtonSystemItemFlexibleSpace, target: nil, action: :nil)

    [left_button, flexible_spacer, center_button, flexible_spacer, right_button]
  end

  # ----------- Action Methods ----------
  def open_left_menu
    self.sideMenuViewController.presentLeftMenuViewController
  end

  def open_right_menu
    self.sideMenuViewController.presentRightMenuViewController
  end

  def open_new_post_controller
    puts '[TL] open_new_post_controller'
  end

  def open_notification_controller
    puts '[TL] open_notification_controller'
    notification_controller = NotificationController.new
    navigation_controller = UINavigationController.alloc.initWithRootViewController(notification_controller)
    navigation_controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve
    self.presentViewController(navigation_controller, animated: true, completion: nil)
  end

  # ----------- RESideMenu Delegate ----------
  # side_menu is instance of RESideMenu
  def sideMenu(side_menu, willShowMenuViewController: menu_view_controller)
    puts "[TL] willShowMenuViewController"
    menu_view_controller.will_show_menu
  end

  def sideMenu(side_menu, didShowMenuViewController: menu_view_controller)
    puts "[TL] didShowMenuViewController"
    menu_view_controller.did_show_menu
  end

  def sideMenu(side_menu, willHideMenuViewController: menu_view_controller)
    puts "[TL] willHideMenuViewController"
  end

  def sideMenu(side_menu, didHideMenuViewController: menu_view_controller)
    puts "[TL] didHideMenuViewController"
  end

  private

  def load_timeline
    puts '[TL] load_timeline'

    rmq(@timeline_label).hide
    @indicator_view.startAnimating

    self.title = @current_room[:name]

    @indicator_view.stopAnimating
    rmq(@timeline_label).show
  end

end
