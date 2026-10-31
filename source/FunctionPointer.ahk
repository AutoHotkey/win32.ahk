#Requires AutoHotkey v2.1-alpha.36

/**
 * Base class for function pointer types.
 * 
 * When a subclass is used as a parameter type, it can accept a user-defined function.
 * A callback with appropriate parameter types is created automatically and retained.
 * It is assumed that the callback address may be retained by native code, so the script must
 * explicitly free the callback with `FP.Free(fn)` if `fn` should ever be released (where FP
 * is the exact subclass of FunctionPointer used to wrap fn).
 * 
 * Subclasses may define the following:
 *   - `static Types`: Array of types for CallbackCreate.
 *   - `static Options`: String of options for CallbackCreate.
 */
struct FunctionPointer {
    p : IntPtr
    __new(fn?) {
        IsSet(fn) && this.__value := fn
    }
    __value {
        set => this.p := ((value?) is Integer ? value
             : this.FtoC[value] ??= CallbackCreate(Value, this.O?, this.T?)) ?? 0
    }
    static __new() {
        this.Prototype.FtoC := Map()
        this.Prototype.T := (this.Types?)
        this.Prototype.O := (this.Options?)
    }
    static Free(fn) {
        CallbackFree(this.Prototype.FtoC.Delete(fn))
    }
}
