module Session_Helper
    
    def session_update( key, value)
        session[key] = value
    end
    
    def session_get(key)
       session[key]
    end
    
    def session_remove()
        reset_session
    end
end