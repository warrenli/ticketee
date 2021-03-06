# encoding: utf-8

def project(name)
  Project.find_by_name!(name)
end

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /首頁/
      '/'
    when /English language/
      '/?locale=en'
    when /中文/
      '/?locale=zh-HK'
    when /the project page for "([^\"]*)"/
      project_path(project($1))
    when /專案"([^\"]*)"/
      project_path(project($1))
    when /the "([^\"]*)" ticket in the "([^\"]*)" project/
      project_ticket_path(project($2), Ticket.find_by_title!($1))
    when /^"([^"]*)"的工作單"([^"]*)"頁面$/
      project_ticket_path(project($1), Ticket.find_by_title!($2))
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
