=begin
This file is part of SSID.

SSID is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

SSID is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with SSID.  If not, see <http://www.gnu.org/licenses/>.
=end

class CoursesController < ApplicationController
  before_filter { |controller|
    if params[:course_id]
      @course = Course.find(params[:course_id])
      controller.send :authenticate_actions_for_role, UserCourseMembership::ROLE_STUDENT,
                                                      course: @course,
                                                      only: [ :index ]
    end
  }

  # GET /courses
  def index
    @courses = @user.courses
  end

  def cluster_students
    respond_to do |format|
      format.json { 
        render json: @course.cluster_students.collect { |s| 
          { id: s.id, id_string: s.id_string } 
        } 
      }
    end
  end
end
