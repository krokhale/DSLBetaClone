class EvaluationsController < ApplicationController

 # Check and display the results of the evaluation of the solution
  def check
     @lesson=Lesson.find(session[:lid])
     if params[:solution]
       eval = solution_correct?
         if eval == true
           flash[:success]="solution is correct !! Go to next lesson"
         else
           mesg_hash=@lesson.messages
           str=""
           eval.each do |e|
             if mesg_hash.has_key?(e)
              str = str+"\n"+mesg_hash[e]
             else
              str = str+"\n"+"check the term #{e}" 
             end
           end
           flash[:error] ="Solution is incorrect.#{str}"  
         end
       else
         flash[:notice]="empty"
       end 
     redirect_to @lesson     
  end
  
private

# see if the solution given by the user is correct
  def solution_correct?
    current = params[:solution].strip
    current.gsub!(/\/\*[\w\s]*\*\//,"") 
    current.gsub!(/--.*\n/,"")
    existing =  format_str(@lesson.solution.strip)
    current = format_str(current.strip)
    if existing == current
      return true
    else
      existing_arr = existing.split
      current_arr = current.split
      len= existing_arr.length
      err =[]
      j=0      
      for i in 0..len
        if existing_arr[i]!=current_arr[i]
          err[j]= existing_arr[i]
          j=j+1  
        end
      end
      return err
    end   
  end
  
 #method for the preprocessing of the string before comparision
  def format_str(str)
    str.gsub!(/ *[\(\),=\*;] */) do |n|
      if (/\(/ =~ n) != nil
        " ( "
      elsif (/\)/ =~ n) != nil
        " ) "
      elsif (/,/ =~ n) != nil  
        " , "
      elsif (/=/ =~ n) != nil
        " = "
      elsif (/;/ =~ n) != nil
        " ; "
      else
        " * "  
      end
    end
  end
  
end
