module NavbarInterfaceTest
  def valid_login_navbar?(user)
    assert_select 'a[href=?]', '/dashboard', text: 'Dashboard'
    assert_select 'a[href=?]', user_path(user), text: 'User Profile'
    assert_select 'a[href=?]', '/logout', text: 'Log Out'
    assert_select 'img'
    assert_select 'i.fa-dashboard'
    assert_select 'i.fa-user'
    assert_select 'i.fa-sign-out'
  end
end
