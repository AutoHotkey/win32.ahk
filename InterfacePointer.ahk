#Requires AutoHotkey v2.1-alpha.36

struct InterfacePointer {
    p : IntPtr
    __new(p := 0) {
        this.p := p
    }
}