struct PWSTR {
    Value : UInt16.Ptr
    __value {
        set {
            if value is String
                StrPut(value, this.value := UInt16[StrPut(value)]())
            else if value is Integer
                NumPut(IntPtr, value, this)
            else
                this.value := value
        }
    }
}
