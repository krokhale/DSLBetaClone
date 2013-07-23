class EvaluationsController < ApplicationController

  def check
     @lesson=Lesson.find(session[:lid])
     if params[:solution]
       if @lesson.solution==params[:solution]
         flash[:success]="solution is correct !! Go to next lesson"
       else
         flash[:error] ="Solution is incorrect.try again"  
       end
     else
       flash[:notice]="empty"
     end 
     redirect_to @lesson     
  end
end
